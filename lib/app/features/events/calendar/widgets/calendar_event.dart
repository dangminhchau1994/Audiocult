import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({Key? key, this.onChanged}) : super(key: key);

  final Function(DateTime startDate, DateTime endTime)? onChanged;

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  bool _todaySelected = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      rangeStartDay: _rangeStart,
      rangeEndDay: _rangeEnd,
      calendarFormat: _calendarFormat,
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
          color: _todaySelected ? AppColors.activeLabelItem : Colors.transparent,
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: AppColors.activeLabelItem,
          shape: BoxShape.circle,
        ),
      ),
      rangeSelectionMode: _rangeSelectionMode,
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
            _rangeStart = null; // Important to clean those
            _rangeEnd = null;
            _todaySelected = false;
            _rangeSelectionMode = RangeSelectionMode.toggledOff;
          });
        }
      },
      onRangeSelected: (start, end, focusedDay) {
        setState(() {
          _selectedDay = null;
          _focusedDay = focusedDay;
          _rangeStart = start;
          _rangeEnd = end;
          _todaySelected = false;
          _rangeSelectionMode = RangeSelectionMode.toggledOn;
          widget.onChanged!(start!, end!);
        });
      },
      onFormatChanged: (format) {
        if (_calendarFormat != format) {
          setState(() {
            _calendarFormat = format;
          });
        }
      },
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
    );
  }
}
