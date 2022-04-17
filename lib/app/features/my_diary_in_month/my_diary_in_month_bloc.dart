import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:intl/intl.dart';

class MyDiaryInMonthBloc extends BaseBloc {
  final AppRepository _appRepository;
  MyDiaryEventRequest? myDiaryParams;
  final _cachedEvents = <DateTime, List<EventResponse>>{};

  final _myEventsStreamController = StreamController<List<EventResponse>>.broadcast();
  Stream<List<EventResponse>> get myEventsStream => _myEventsStreamController.stream;

  MyDiaryInMonthBloc(this._appRepository);

  void loadAllEventsInMyDiary({required DateTime startDate, required DateTime endDate}) async {
    final cachedEvents = _getEventsFromCached(startDate);
    if (cachedEvents != null && cachedEvents.isNotEmpty) {
      _myEventsStreamController.sink.add(cachedEvents);
      return;
    }

    showOverLayLoading();
    const formatStr = 'yyyy-MM-dd';

    myDiaryParams?.startDate = DateFormat(formatStr).format(startDate);
    myDiaryParams?.endDate = DateFormat(formatStr).format(endDate);

    final result = await _appRepository.getMyDiaryEvents(
      (myDiaryParams?..limit = 100) ?? MyDiaryEventRequest()
        ..limit = 100,
    );
    result.fold(
      (events) {
        _cacheEventsByStartDate(dateTime: startDate, events: events);
        hideOverlayLoading();
        _myEventsStreamController.sink.add(events);
      },
      (error) {
        hideOverlayLoading();
        _myEventsStreamController.sink.add([]);
      },
    );
  }

  void _cacheEventsByStartDate({required DateTime dateTime, required List<EventResponse> events}) {
    _cachedEvents[dateTime] = events;
  }

  List<EventResponse>? _getEventsFromCached(DateTime dateTime) {
    return _cachedEvents[dateTime];
  }
}
