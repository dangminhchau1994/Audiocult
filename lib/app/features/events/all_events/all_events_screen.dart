import 'package:audio_cult/app/features/events/all_event_bloc.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/all_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/event_filter.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/popular_events.dart';
import 'package:audio_cult/app/features/events/all_events/widgets/show_events.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/app/view/no_data_widget.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/w_components/loading/loading_builder.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../popular_event_bloc.dart';

class AllEventsScreen extends StatefulWidget {
  const AllEventsScreen({Key? key}) : super(key: key);

  @override
  State<AllEventsScreen> createState() => _AllEventsScreenState();
}

class _AllEventsScreenState extends State<AllEventsScreen> with AutomaticKeepAliveClientMixin {
  late AllEventBloc _allEventBloc;
  final PagingController<int, EventResponse> _pagingAllEventController = PagingController(firstPageKey: 1);
  final PagingController<int, EventResponse> _pagePopularEventController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingAllEventController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
    _allEventBloc = getIt.get<AllEventBloc>();
    _allEventBloc.requestData(
      params: EventRequest(
        page: 1,
        limit: GlobalConstants.loadMoreItem,
      ),
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _allEventBloc.loadData(
        EventRequest(
          page: pageKey,
          limit: GlobalConstants.loadMoreItem,
        ),
      );
      newItems.fold(
        (l) {
          final isLastPage = l.length < GlobalConstants.loadMoreItem;
          if (isLastPage) {
            _pagingAllEventController.appendLastPage(l);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingAllEventController.appendPage(l, nextPageKey);
          }
        },
        (r) => _allEventBloc.showError,
      );
    } catch (error) {
      _pagingAllEventController.error = error;
    }
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          _pagePopularEventController.refresh();
          _pagingAllEventController.refresh();
          getIt<AllEventBloc>().requestData(params: EventRequest(page: 1, limit: GlobalConstants.loadMoreItem));
          getIt<PopularEventBloc>().requestData(
            params: EventRequest(
              query: '',
              sort: 'most-liked',
              page: 1,
              limit: GlobalConstants.loadMoreItem,
            ),
          );
        },
        child: LoadingBuilder<AllEventBloc, List<EventResponse>>(
          noDataBuilder: (state) {
            return const NoDataWidget();
          },
          builder: (data, _) {
            // only first page
            final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              _pagingAllEventController.appendLastPage(data);
            } else {
              _pagingAllEventController.appendPage(data, _pagingAllEventController.firstPageKey + 1);
            }
            return CustomScrollView(
              slivers: [
                const ShowEvents(),
                PopularEvents(
                  pagingController: _pagePopularEventController,
                ),
                const EventFilter(),
                AllEvents(
                  pagingController: _pagingAllEventController,
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
            _pagingAllEventController.refresh();
            _allEventBloc.requestData(
              params: EventRequest(
                query: '',
                page: 1,
                limit: GlobalConstants.loadMoreItem,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
