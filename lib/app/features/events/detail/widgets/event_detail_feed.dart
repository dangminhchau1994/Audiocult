import 'package:audio_cult/app/features/events/detail/event_detail_bloc.dart';
import 'package:audio_cult/app/features/home/widgets/announcement_post.dart';
import 'package:audio_cult/app/features/home/widgets/feed_item.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../w_components/dialogs/report_dialog.dart';
import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../data_source/models/requests/feed_request.dart';
import '../../../../data_source/models/responses/feed/feed_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/route/app_route.dart';

class EventDetailFeed extends StatefulWidget {
  const EventDetailFeed({
    Key? key,
    this.eventId,
    this.scrollController,
  }) : super(key: key);

  final int? eventId;
  final ScrollController? scrollController;

  @override
  State<EventDetailFeed> createState() => _EventDetailFeedState();
}

class _EventDetailFeedState extends State<EventDetailFeed> {
  final PagingController<int, FeedResponse> _pagingFeedController = PagingController(firstPageKey: 1);
  late EventDetailBloc _eventDetaiBloc;

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
    _eventDetaiBloc = getIt.get<EventDetailBloc>();
    _eventDetaiBloc.requestData(
      params: FeedRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
        eventId: widget.eventId,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey, int lastFeedId) async {
    try {
      final newItems = await _eventDetaiBloc.loadData(
        FeedRequest(
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
          lastFeedId: lastFeedId,
          eventId: widget.eventId,
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
        (r) => _eventDetaiBloc.showError,
      );
    } catch (error) {
      _pagingFeedController.error = error;
    }
  }

  void _editFeed(FeedResponse item) async {
    final result = await Navigator.pushNamed(context, AppRoute.routeEditFeed, arguments: {'feed_response': item});
    if (result != null) {
      final feed = result as FeedResponse;
      _eventDetaiBloc.editFeedItem(_pagingFeedController, feed);
    }
  }

  void _deleteFeed(FeedResponse item, int index) {
    _eventDetaiBloc.deleteFeedItem(_pagingFeedController, index);
    _eventDetaiBloc.deleteFeed(int.parse(item.feedId ?? ''));
  }

  void _onReport(FeedResponse item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: Builder(
          builder: (context) => ReportDialog(
            type: ReportType.feed,
            itemId: int.parse(item.feedId ?? ''),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawScrollbar(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: RefreshIndicator(
            color: AppColors.primaryButtonColor,
            backgroundColor: AppColors.secondaryButtonColor,
            onRefresh: () async {
              _pagingFeedController.refresh();
              _eventDetaiBloc.requestData(
                params: FeedRequest(
                  page: 1,
                  limit: GlobalConstants.loadMoreItem,
                  eventId: widget.eventId,
                ),
              );
            },
            child: LoadingBuilder<EventDetailBloc, List<FeedResponse>>(
              noDataBuilder: (state) {
                return CustomScrollView(
                  slivers: [
                    AnnouncementPost(
                      eventId: widget.eventId,
                      callData: () {
                        _pagingFeedController.refresh();
                        _eventDetaiBloc.requestData(
                          params: FeedRequest(
                            page: 1,
                            limit: GlobalConstants.loadMoreItem,
                            eventId: widget.eventId,
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
              builder: (data, _) {
                // only first page
                final isLastPage = data.length <= GlobalConstants.loadMoreItem - 1;
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
                        _eventDetaiBloc.requestData(
                          params: FeedRequest(
                            page: 1,
                            limit: GlobalConstants.loadMoreItem,
                            eventId: widget.eventId,
                          ),
                        );
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 40)),
                    StreamBuilder<PagingController<int, FeedResponse>>(
                      initialData: _pagingFeedController,
                      stream: _eventDetaiBloc.pagingControllerStream,
                      builder: (context, snapshot) => PagedSliverList<int, FeedResponse>.separated(
                        pagingController: snapshot.data!,
                        separatorBuilder: (context, index) => const Divider(height: 24),
                        builderDelegate: PagedChildBuilderDelegate<FeedResponse>(
                          firstPageProgressIndicatorBuilder: (context) => Container(),
                          newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                          animateTransitions: true,
                          itemBuilder: (context, item, index) {
                            return FeedItem(
                              data: item,
                              onReport: () {
                                _onReport(item);
                              },
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
                _eventDetaiBloc.requestData(
                  params: FeedRequest(
                    page: 1,
                    limit: GlobalConstants.loadMoreItem,
                    eventId: widget.eventId,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
