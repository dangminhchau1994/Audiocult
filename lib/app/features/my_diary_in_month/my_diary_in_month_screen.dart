import 'package:audio_cult/app/base/bloc_handle.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/features/events/my_diary/my_diary_event_widget.dart';
import 'package:audio_cult/app/features/my_diary_in_month/my_diary_in_month_bloc.dart';
import 'package:audio_cult/app/utils/constants/app_colors.dart';
import 'package:audio_cult/di/bloc_locator.dart';
import 'package:audio_cult/l10n/l10n.dart';
import 'package:audio_cult/w_components/appbar/common_appbar.dart';
import 'package:audio_cult/w_components/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../../utils/extensions/app_extensions.dart';

class MyDiaryInMonthScreen extends StatefulWidget {
  final MyDiaryEventRequest? myDiaryParams;

  const MyDiaryInMonthScreen({Key? key, this.myDiaryParams}) : super(key: key);

  @override
  State<MyDiaryInMonthScreen> createState() => _MyDiaryInMonthScreenState();
}

class _MyDiaryInMonthScreenState extends State<MyDiaryInMonthScreen> {
  final _calendarController = CalendarController();
  late MyDiaryInMonthBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = getIt.get<MyDiaryInMonthBloc>();
    _bloc.myDiaryParams = widget.myDiaryParams;
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: DateTime.now().year.toString(),
        actions: [
          TextButton(
            onPressed: _todayButtonOnTap,
            child: Text(context.l10n.t_today),
          ),
        ],
      ),
      body: BlocHandle(
        bloc: _bloc,
        child: SfCalendarTheme(
          data: SfCalendarThemeData(
            brightness: Brightness.dark,
            backgroundColor: AppColors.mainColor,
            viewHeaderDayTextStyle: context.body1TextStyle(),
            agendaDayTextStyle: context.body1TextStyle(),
            timeTextStyle: context.body1TextStyle(),
            weekNumberTextStyle: context.body1TextStyle(),
            activeDatesTextStyle: context.body1TextStyle(),
            blackoutDatesTextStyle: context.body1TextStyle()?.copyWith(color: AppColors.deepTeal),
            leadingDatesTextStyle: context.body1TextStyle()?.copyWith(color: AppColors.unActiveLabelItem.withAlpha(50)),
            trailingDatesTextStyle:
                context.body1TextStyle()?.copyWith(color: AppColors.unActiveLabelItem.withAlpha(50)),
            todayHighlightColor: AppColors.persianGreen,
            cellBorderColor: Colors.blueGrey.withAlpha(80),
            selectionBorderColor: AppColors.persianGreen,
            headerTextStyle: context.bodyTextPrimaryStyle()?.copyWith(fontWeight: FontWeight.bold),
            viewHeaderDateTextStyle: context.bodyTextPrimaryStyle(),
          ),
          child: _calendarWidget(),
        ),
      ),
    );
  }

  void _todayButtonOnTap() {
    final today = DateTime.now();
    _calendarController.selectedDate = today;
    _calendarController.displayDate = today;
  }

  Widget _calendarWidget() {
    return StreamBuilder<List<EventResponse>>(
      initialData: const [],
      stream: _bloc.myEventsStream,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        return SfCalendar(
          controller: _calendarController,
          onViewChanged: (details) {
            _bloc.loadAllEventsInMyDiary(
              startDate: details.visibleDates.first,
              endDate: details.visibleDates.last,
            );
          },
          view: CalendarView.month,
          firstDayOfWeek: 1,
          dataSource: EventCalendarDatasource(snapshot.data!),
          monthViewSettings: const MonthViewSettings(appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
          onTap: (details) {
            if (details.appointments?.isNotEmpty == true) {
              _selectDateOnCalendar(details.appointments!);
            }
          },
        );
      },
    );
  }

  void _selectDateOnCalendar(List<dynamic> events) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isScrollControlled: false,
      context: context,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(24),
              right: Radius.circular(24),
            ),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 12),
            itemCount: events.length,
            itemBuilder: (_, index) {
              return MyDiaryEventWidget(events[index] as EventResponse);
            },
          ),
        );
      },
    );
  }
}

class EventCalendarDatasource extends CalendarDataSource {
  EventCalendarDatasource(List<EventResponse> source) {
    appointments = source;
  }

  @override
  String getSubject(int index) {
    return appointments?[index].title as String;
  }

  @override
  DateTime getStartTime(int index) {
    final timeStamp = int.parse(appointments?[index]?.startTime as String);
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toUtc();
    return DateTime(date.year, date.month, date.day);
  }

  @override
  DateTime getEndTime(int index) {
    final timeStamp = int.parse(appointments?[index]?.startTime as String);
    final date = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000).toUtc();
    return DateTime(date.year, date.month, date.day);
  }
}
