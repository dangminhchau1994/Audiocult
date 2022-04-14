import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class MyDiaryInMonthBloc extends BaseBloc {
  final AppRepository _appRepository;

  final _myEventsStreamController = StreamController<List<EventResponse>>.broadcast();
  Stream<List<EventResponse>> get myEventsStream => _myEventsStreamController.stream;

  MyDiaryInMonthBloc(this._appRepository);

  void loadAllEventsInMyDiary() async {
    final result = await _appRepository.getMyDiaryEvents(MyDiaryEventRequest()..limit = 100);
    result.fold(
      (events) {
        _myEventsStreamController.sink.add(events);
      },
      (error) {
        _myEventsStreamController.sink.add([]);
      },
    );
  }
}
