import 'package:audio_cult/app/data_source/models/requests/event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/popular_event_item.dart';
import 'package:audio_cult/app/features/events/popular_event_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_dimens.dart';
import 'package:audio_cult/app/utils/extensions/app_extensions.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../music/library/widgets/empty_playlist.dart';

class PopularEvents extends StatefulWidget {
  const PopularEvents({Key? key, this.pagingController}) : super(key: key);

  final PagingController<int, EventResponse>? pagingController;

  @override
  State<PopularEvents> createState() => _PopularEventsState();
}

class _PopularEventsState extends State<PopularEvents> {
  late PopularEventBloc _popularEventBloc;
  late PagingController<int, EventResponse> _pagingController;

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _popularEventBloc.loadData(
        EventRequest(
          query: '',
          sort: 'most-liked',
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(l, nextPageKey);
          }
        },
        (r) => _popularEventBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController = widget.pagingController!;
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _popularEventBloc = getIt<PopularEventBloc>();
    _popularEventBloc.requestData(
      params: EventRequest(
        query: '',
        sort: 'most-liked',
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalSpacing,
            vertical: kVerticalSpacing,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.t_popular_events,
                style: context.bodyTextStyle()?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: LoadingBuilder<PopularEventBloc, List<EventResponse>>(
                  noDataBuilder: (state) {
                    return const NoDataWidget();
                  },
                  builder: (data, _) {
                    //only first page
                    final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
                    if (isLastPage) {
                      _pagingController.appendLastPage(data);
                    } else {
                      _pagingController.appendPage(data, _pagingController.firstPageKey + 1);
                    }
                    return Scrollbar(
                      child: PagedListView<int, EventResponse>.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        pagingController: _pagingController,
                        separatorBuilder: (context, index) => const SizedBox(width: 1),
                        builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                          firstPageProgressIndicatorBuilder: (context) => Container(),
                          newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                          animateTransitions: true,
                          itemBuilder: (context, item, index) {
                            return PopularEventItem(
                              data: item,
                            );
                          },
                        ),
                      ),
                    );
                  },
                  reloadAction: (_) {
                    _pagingController.refresh();
                    _popularEventBloc.requestData(
                      params: EventRequest(
                        query: '',
                        sort: 'most-liked',
                        page: 1,
                        limit: GlobalConstants.loadMoreItem,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
