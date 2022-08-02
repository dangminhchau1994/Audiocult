import 'package:audio_cult/app/constants/global_constants.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/profile/profile_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/constants/app_font_sizes.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/images/common_image_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../../../di/bloc_locator.dart';
import '../../../../w_components/buttons/w_button_inkwell.dart';
import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/loading/loading_builder.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/feed_request.dart';
import '../../../data_source/models/responses/feed/feed_response.dart';
import '../../../utils/constants/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/route/app_route.dart';
import '../../home/home_bloc.dart';
import '../../home/widgets/feed_item.dart';
import '../profile_screen.dart';

class PostPage extends StatefulWidget {
  final ScrollController? scrollController;
  final ProfileData? profile;
  const PostPage({Key? key, this.profile, this.scrollController}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  double height = 8;
  final PagingController<int, FeedResponse> _pagingFeedController = PagingController(firstPageKey: 1);
  late HomeBloc _homeBloc;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.scrollController!
          .animateTo(_scrollController.offset, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    });
    widget.scrollController?.addListener(() {
      if (widget.scrollController!.offset > 350) {
        setState(() {
          height = (widget.scrollController!.offset - 350) + 64;
        });
      } else {
        setState(() {
          height = 8;
        });
      }
    });
    Provider.of<ProfileBloc>(context, listen: false)
        .getListSubscriptions(widget.profile?.userId, 1, GlobalConstants.loadMoreItem);
    _pagingFeedController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(
          pageKey,
          int.parse(_pagingFeedController.itemList?.last.feedId ?? ''),
        );
      }
    });
    _homeBloc = getIt.get<HomeBloc>();
    _homeBloc.requestData(
      params: FeedRequest(page: 1, limit: GlobalConstants.loadMoreItem, userId: widget.profile?.userId),
    );
  }

  Future<void> _fetchPage(int pageKey, int lastFeedId) async {
    try {
      final newItems = await _homeBloc.loadData(
        FeedRequest(
            page: pageKey, limit: GlobalConstants.loadMoreItem, lastFeedId: lastFeedId, userId: widget.profile?.userId),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingFeedController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingFeedController.appendPage(l, nextPageKey);
          }
        },
        (r) => _homeBloc.showError,
      );
    } catch (error) {
      _pagingFeedController.error = error;
    }
  }

  void _editFeed(FeedResponse item) async {
    final result = await Navigator.pushNamed(context, AppRoute.routeEditFeed, arguments: {'feed_response': item});
    if (result != null) {
      final feed = result as FeedResponse;
      _homeBloc.editFeedItem(_pagingFeedController, feed);
    }
  }

  void _deleteFeed(FeedResponse item, int index) {
    _homeBloc.deleteFeedItem(_pagingFeedController, index);
    _homeBloc.deleteFeed(int.parse(item.feedId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height),
        Container(
          margin: const EdgeInsets.all(kVerticalSpacing),
          padding: const EdgeInsets.all(kVerticalSpacing),
          decoration: BoxDecoration(color: AppColors.ebonyClay),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    context.l10n.t_subscriptions,
                    style:
                        context.body1TextStyle()?.copyWith(fontSize: AppFontSize.size18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: kHorizontalSpacing / 2,
                  ),
                  Text(
                    '${widget.profile?.totalSubscribers ?? 0}',
                    style: context.body1TextStyle()?.copyWith(color: AppColors.subTitleColor),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  WButtonInkwell(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoute.routeSubscriptions,
                          arguments: {'user_id': widget.profile?.userId});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Show All',
                        style: context.bodyTextPrimaryStyle()!.copyWith(
                              fontSize: 16,
                              color: AppColors.lightBlue,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 96,
                child: StreamBuilder<BlocState<List<ProfileData>>>(
                    initialData: const BlocState.loading(),
                    stream: Provider.of<ProfileBloc>(context, listen: false).getListSubscriptionsStream,
                    builder: (context, snapshot) {
                      final state = snapshot.data!;
                      return state.when(
                        success: (data) {
                          final subscriptions = data as List<ProfileData>;
                          return ListView.builder(
                              itemCount: subscriptions.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (_, index) {
                                return WButtonInkwell(
                                  onPressed: () {
                                    Navigator.pushNamed(context, AppRoute.routeProfile,
                                        arguments: ProfileScreen.createArguments(id: subscriptions[index].userId!));
                                  },
                                  child: Container(
                                    width: 96,
                                    height: 96,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kVerticalSpacing / 2, vertical: kVerticalSpacing / 2),
                                    child: CircleAvatar(
                                      child: ClipOval(
                                        child: CommonImageNetWork(
                                          width: 96,
                                          height: 96,
                                          imagePath: subscriptions[index].userImage ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        loading: () {
                          return const Center(child: LoadingWidget());
                        },
                        error: (error) {
                          return ErrorSectionWidget(
                            errorMessage: error,
                            onRetryTap: () {
                              Provider.of<ProfileBloc>(context, listen: false)
                                  .getListSubscriptions(widget.profile?.userId, 1, GlobalConstants.loadMoreItem);
                            },
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
        WButtonInkwell(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, AppRoute.routeCreatePost, arguments: {
              'user_id': widget.profile?.userId,
            });

            if (result != null) {
              _pagingFeedController.refresh();
              _homeBloc.requestData(
                params: FeedRequest(
                  page: 1,
                  userId: widget.profile?.userId,
                  limit: GlobalConstants.loadMoreItem,
                ),
              );
            }
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: AppColors.secondaryButtonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.activeEdit,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  context.l10n.t_create_post,
                  style: TextStyle(
                    color: AppColors.activeLabelItem,
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LoadingBuilder<HomeBloc, List<FeedResponse>>(
              builder: (data, _) {
                // only first page
                final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                if (isLastPage) {
                  _pagingFeedController.appendLastPage(data);
                } else {
                  _pagingFeedController.appendPage(data, _pagingFeedController.firstPageKey + 1);
                }

                return StreamBuilder<PagingController<int, FeedResponse>>(
                  initialData: _pagingFeedController,
                  stream: _homeBloc.pagingControllerStream,
                  builder: (context, snapshot) => PagedListView<int, FeedResponse>.separated(
                    scrollController: _scrollController,
                    pagingController: snapshot.data!,
                    separatorBuilder: (context, index) => const Divider(height: 24),
                    builderDelegate: PagedChildBuilderDelegate<FeedResponse>(
                      firstPageProgressIndicatorBuilder: (context) => Container(),
                      newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        return FeedItem(
                          data: item,
                          onEdit: () {
                            _editFeed(item);
                          },
                          onDelete: () {
                            _deleteFeed(item, index);
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
