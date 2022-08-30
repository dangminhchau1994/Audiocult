import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/extensions/app_extensions.dart';

class CalendarTable extends StatefulWidget {
  const CalendarTable({
    Key? key,
    this.listCalendar,
    this.query,
    this.callData,
    this.locale,
  }) : super(key: key);

  final List<ValueNotifier<dynamic>>? listCalendar;
  final String? query;
  final String? locale;
  final Function(String query, int page, DateTime startDate, DateTime endDate)? callData;

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: widget.listCalendar!,
      builder: (context, values, child) {
        final currentDate = asType<DateTime>(values.elementAt(0));
        final selectedDate = asType<DateTime>(values.elementAt(1));
        final rangeStartDate = asType<DateTime>(values.elementAt(2));
        final rangeEndDate = asType<DateTime>(values.elementAt(3));
        final todaySelected = asType<bool>(values.elementAt(4));
        final formatCalendar = asType<CalendarFormat>(values.elementAt(5));
        final rangeSelectionMode = asType<RangeSelectionMode>(values.elementAt(6));

        return TableCalendar(
          locale: widget.locale,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: currentDate!,
          selectedDayPredicate: (day) => isSameDay(selectedDate, day),
          rangeStartDay: rangeStartDate,
          rangeEndDay: rangeEndDate,
          calendarFormat: formatCalendar!,
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white),
          ),
          calendarStyle: CalendarStyle(
            disabledTextStyle: const TextStyle(color: Colors.white),
            selectedTextStyle: const TextStyle(color: Colors.white),
            weekendTextStyle: const TextStyle(color: Colors.white),
            rangeStartDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: todaySelected! ? AppColors.activeLabelItem : Colors.transparent,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: AppColors.activeLabelItem,
              shape: BoxShape.circle,
            ),
          ),
          rangeSelectionMode: rangeSelectionMode!,
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(selectedDate, selectedDay)) {
              widget.listCalendar?[1].value = selectedDay;
              widget.listCalendar?[0].value = focusedDay;
              widget.listCalendar?[2].value = null; // Important to clean those
              widget.listCalendar?[3].value = null;
              widget.listCalendar?[4].value = false;
              widget.listCalendar?[6].value = RangeSelectionMode.toggledOff;
            }
          },
          onRangeSelected: (start, end, focusedDay) {
            widget.listCalendar?[1].value = null;
            widget.listCalendar?[0].value = focusedDay;
            widget.listCalendar?[2].value = start;
            widget.listCalendar?[3].value = end;
            widget.listCalendar?[4].value = false;
            widget.listCalendar?[6].value = RangeSelectionMode.toggledOn;

            widget.callData!(widget.query ?? '', 1, start!, end!);
          },
          onFormatChanged: (format) {
            if (formatCalendar != format) {
              widget.listCalendar?[5].value = format;
            }
          },
          onPageChanged: (focusedDay) {
            widget.listCalendar?[0].value = focusedDay;
          },
        );
      },
    );
  }
}
