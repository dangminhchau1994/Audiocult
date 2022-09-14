import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/app/features/events/all_event_bloc.dart';
import 'package:audio_cult/app/injections.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../w_components/error_empty/error_section.dart';
import '../../../../w_components/error_empty/widget_state.dart';
import '../../../../w_components/loading/loading_widget.dart';
import '../../../constants/global_constants.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../utils/constants/app_dimens.dart';
import '../../events/all_events/widgets/all_event_item.dart';

class EventsPage extends StatefulWidget {
  final ProfileData profile;
  final ScrollController scrollController;

  const EventsPage({Key? key, required this.scrollController, required this.profile}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final PagingController<int, EventResponse> _pagingController = PagingController(firstPageKey: 1);
  final ScrollController _scrollController = ScrollController();
  final AllEventBloc _allEventBloc = AllEventBloc(locator.get());
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.scrollController
          .animateTo(_scrollController.offset, duration: const Duration(milliseconds: 50), curve: Curves.easeOut);
    });
    _fetchPage(1);
    _pagingController.addPageRequestListener((pageKey) {
      if (pageKey > 1) {
        _fetchPage(pageKey);
      }
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _allEventBloc.loadData(
        EventRequest(page: pageKey, limit: GlobalConstants.loadMoreItem, userId: widget.profile.userId),
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
        (r) => _allEventBloc.showError,
      );
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Padding(
        padding: const EdgeInsets.all(kVerticalSpacing),
        child: RawScrollbar(
          child: PagedListView<int, EventResponse>.separated(
            separatorBuilder: (context, index) => const Divider(height: 24),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ),
            scrollController: _scrollController,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<EventResponse>(
              firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
              noItemsFoundIndicatorBuilder: (_) => const EmptyDataStateWidget(null),
              firstPageErrorIndicatorBuilder: (_) {
                return ErrorSectionWidget(
                  errorMessage: _pagingController.error as String,
                  onRetryTap: () {
                    _pagingController.refresh();
                    _fetchPage(1);
                  },
                );
              },
              itemBuilder: (context, item, index) {
                return AllEventItem(
                  data: item,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
