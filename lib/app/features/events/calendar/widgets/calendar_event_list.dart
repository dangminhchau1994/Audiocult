import 'package:audio_cult/app/features/events/calendar/calendar_bloc.dart';
import 'package:audio_cult/app/features/events/calendar/widgets/calendar_event_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../w_components/loading/loading_builder.dart';
import '../../../../../w_components/loading/loading_widget.dart';
import '../../../../constants/global_constants.dart';
import '../../../../data_source/models/responses/events/event_response.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../view/no_data_widget.dart';

class CalendarEventList extends StatefulWidget {
  const CalendarEventList({
    Key? key,
    this.pagingController,
    this.query,
    this.page,
    this.rangeStart,
    this.rangeEnd,
    this.callData,
  }) : super(key: key);

  final PagingController<int, EventResponse>? pagingController;
  final Function(String query, int page, DateTime start, DateTime end)? callData;
  final String? query;
  final int? page;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;

  @override
  State<CalendarEventList> createState() => _CalendarEventListState();
}

class _CalendarEventListState extends State<CalendarEventList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: AppColors.primaryButtonColor,
        backgroundColor: AppColors.secondaryButtonColor,
        onRefresh: () async {
          widget.pagingController?.refresh();
          widget.callData!(
            widget.query ?? '',
            widget.page ?? 0,
            widget.rangeStart ?? DateTime.now(),
            widget.rangeEnd ?? DateTime.now(),
          );
        },
        child: LoadingBuilder<CalendarBloc, List<EventResponse>>(
          noDataBuilder: (state) {
            return const NoDataWidget();
          },
          builder: (data, _) {
            //only first page
            final isLastPage = data.length == GlobalConstants.loadMoreItem - 1;
            if (isLastPage) {
              widget.pagingController?.appendLastPage(data);
            } else {
              widget.pagingController?.appendPage(data, widget.pagingController!.firstPageKey + 1);
            }
            return PagedListView<int, EventResponse>.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              pagingController: widget.pagingController!,
              separatorBuilder: (context, index) => const Divider(height: 24),
              builderDelegate: PagedChildBuilderDelegate<EventResponse>(
                firstPageProgressIndicatorBuilder: (context) => Container(),
                newPageProgressIndicatorBuilder: (context) => const LoadingWidget(),
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return CalendarEventItem(
                    data: item,
                  );
                },
              ),
            );
          },
          reloadAction: (_) {
            widget.pagingController!.refresh();
            widget.callData!(
              widget.query ?? '',
              widget.page ?? 0,
              widget.rangeStart ?? DateTime.now(),
              widget.rangeEnd ?? DateTime.now(),
            );
          },
        ),
      ),
    );
  }
}
