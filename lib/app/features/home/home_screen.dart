import 'package:audio_cult/app/data_source/models/requests/feed_request.dart';
import 'package:audio_cult/app/data_source/models/responses/feed/feed_response.dart';
import 'package:audio_cult/app/features/home/home_bloc.dart';
import 'package:audio_cult/app/features/home/widgets/announcement_post.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../w_components/loading/loading_widget.dart';
import '../../constants/global_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final PagingController<int, FeedResponse> _pagingFeedController = PagingController(firstPageKey: 1);
  late HomeBloc _homeBloc;
  String a = 'fsdfsdf';

  @override
  void initState() {
    super.initState();
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
      params: FeedRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey, int lastFeedId) async {
    try {
      final newItems = await _homeBloc.loadData(
        FeedRequest(
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          lastFeedId: lastFeedId,
        ),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: RefreshIndicator(
            color: AppColors.primaryButtonColor,
            backgroundColor: AppColors.secondaryButtonColor,
            onRefresh: () async {
              _pagingFeedController.refresh();
              _homeBloc.requestData(
                params: FeedRequest(
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                ),
              );
            },
            child: LoadingBuilder<HomeBloc, List<FeedResponse>>(
              noDataBuilder: (state) {
                return CustomScrollView(
                  slivers: [
                    AnnouncementPost(
                      callData: () {
                        _pagingFeedController.refresh();
                        _homeBloc.requestData(
                          params: FeedRequest(
                            page: 1,
                            limit: GlobalConstants.loadMoreItem,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              builder: (data, _) {
                // only first page
                final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                if (isLastPage) {
                  _pagingFeedController.appendLastPage(data);
                } else {
                  _pagingFeedController.appendPage(data, _pagingFeedController.firstPageKey + 1);
                }

                return CustomScrollView(
                  slivers: [
                    AnnouncementPost(
                      callData: () {
                        _pagingFeedController.refresh();
                        _homeBloc.requestData(
                          params: FeedRequest(
                            page: 1,
                            limit: GlobalConstants.loadMoreItem,
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                    PagedSliverList<int, FeedResponse>.separated(
                      pagingController: _pagingFeedController,
                      separatorBuilder: (context, index) => const Divider(height: 24),
                      builderDelegate: PagedChildBuilderDelegate<FeedResponse>(
                        firstPageProgressIndicatorBuilder: (context) => Container(),
                        newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return FeedItem(
                            data: item,
                            onDelete: () {
                              setState(() {
                                _pagingFeedController.itemList?.removeAt(index);
                                _homeBloc.deleteFeed(int.parse(item.feedId ?? ''));
                              });
                            },
                          );
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 150),
                        child: Container(),
                      ),
                    )
                  ],
                );
              },
              reloadAction: (_) {
                _pagingFeedController.refresh();
                _homeBloc.requestData(
                  params: FeedRequest(
                    page: 1,
                    limit: GlobalConstants.loadMoreItem,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
