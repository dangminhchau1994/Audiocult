part of 'my_diary_screen.dart';

class MyDiaryCalendarWidget extends StatefulWidget {
  final DateTime? startDateInRange;
  final DateTime? endDateInRange;
  final Function(Tuple2<DateTime?, DateTime?>) focusRangeDateOnChanged;

  const MyDiaryCalendarWidget(
      {required this.startDateInRange, required this.endDateInRange, required this.focusRangeDateOnChanged, Key? key})
      : super(key: key);

  @override
  State<MyDiaryCalendarWidget> createState() => _MyDiaryCalendarWidgetState();
}

class _MyDiaryCalendarWidgetState extends State<MyDiaryCalendarWidget> {
  var _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  Widget build(BuildContext context) {
    return TableCalendar<EventResponse>(
      focusedDay: widget.endDateInRange ?? widget.startDateInRange ?? DateTime.now(),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      startingDayOfWeek: StartingDayOfWeek.monday,
      selectedDayPredicate: (day) => isSameDay(widget.startDateInRange, day),
      calendarFormat: CalendarFormat.week,
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white),
        weekendStyle: TextStyle(color: Colors.white),
      ),
      rangeStartDay: widget.startDateInRange,
      rangeEndDay: widget.endDateInRange,
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
          color: AppColors.activeLabelItem,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.activeLabelItem,
          shape: BoxShape.circle,
        ),
      ),
      rangeSelectionMode: _rangeSelectionMode,
      onRangeSelected: (start, middle, end) {
        widget.focusRangeDateOnChanged(Tuple2(start, middle));
        _rangeSelectionMode = RangeSelectionMode.toggledOn;
        setState(() {});
      },
      onDaySelected: (selectedDay, _) {
        widget.focusRangeDateOnChanged(Tuple2(selectedDay, null));
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        setState(() {});
      },
    );
  }
}
