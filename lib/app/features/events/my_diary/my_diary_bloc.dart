import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/event_view_entity.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class MyDiaryBloc extends BaseBloc {
  DateTime? _selectedDate;

  final AppRepository _appRepository;
  List<EventViewEntity>? _eventViews;
  List<EventViewEntity> get eventViews => _eventViews ?? [];
  int get numberOfItems => 10;
  bool? _isScrollToTop;

  MyDiaryBloc(this._appRepository);

  final _selectedDateTimeStreamController = StreamController<DateTime>.broadcast();
  Stream<DateTime> get currentDateTimeStream => _selectedDateTimeStreamController.stream;

  final _myEventsStreamController = StreamController<BlocState<List<EventResponse>>>.broadcast();
  Stream<BlocState<List<EventResponse>>> get myEventsStream => _myEventsStreamController.stream;

  final _viewScrollStreamController = StreamController<bool>.broadcast();
  Stream<bool> get viewScrollStream => _viewScrollStreamController.stream;

  final _eventViewStreamController = StreamController<List<EventViewEntity>>.broadcast();
  Stream<List<EventViewEntity>> get eventViewStream => _eventViewStreamController.stream;

  void initMetadataOfEventView(BuildContext context) {
    _eventViews = [
      EventViewEntity()
        ..view = MyDiaryEventView.all
        ..isSelected = true,
      EventViewEntity()..view = MyDiaryEventView.notAttending,
      EventViewEntity()..view = MyDiaryEventView.attending,
      EventViewEntity()..view = MyDiaryEventView.mayAttend,
    ];
    _eventViewStreamController.sink.add(_eventViews!);
  }

  void dateTimeOnChanged(DateTime dateTime) {
    _selectedDate = dateTime;
    _selectedDateTimeStreamController.sink.add(dateTime);
  }

  void loadEvents({int? pageNumber, DateTime? dateTime, EventViewEntity? eventView}) async {
    showOverLayLoading();
    final request = MyDiaryEventRequest()
      ..pageNumber = pageNumber
      ..dateTime = DateFormat('yyyy-MM-dd').format(_selectedDate ?? DateTime.now())
      ..view = _eventViews?.firstWhereOrNull((element) => element.isSelected == true)?.view ?? MyDiaryEventView.all
      ..limit = numberOfItems;
    final result = await _appRepository.getMyDiaryEvents(request);
    result.fold((result) {
      _myEventsStreamController.sink.add(BlocState.success(result));
      hideOverlayLoading();
    }, (exception) {
      _myEventsStreamController.sink.add(BlocState.error(exception.toString()));
      hideOverlayLoading();
    });
  }

  void filterEventsByView(EventViewEntity eventView) {
    final previousIndex = _eventViews?.indexWhere((element) => element.isSelected);
    final index = _eventViews?.indexWhere((element) => element == eventView);
    if (previousIndex != null && previousIndex >= 0 && previousIndex < (_eventViews?.length ?? 0)) {
      _eventViews?[previousIndex].isSelected = false;
    }
    if (index != null && index >= 0 && index < (_eventViews?.length ?? 0)) {
      _eventViews?[index].isSelected = true;
    }
    _eventViewStreamController.sink.add(_eventViews ?? []);
  }

  void viewIsScrolling(double offset) {
    if (offset > 70) {
      _viewScrollStreamController.sink.add(_isScrollToTop ?? false);
    } else {
      _viewScrollStreamController.sink.add(true);
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void viewStartScroll(bool isScrollingToTop) {
    _isScrollToTop = isScrollingToTop;
  }
}
