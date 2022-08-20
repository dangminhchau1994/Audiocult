import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/event_view_wrapper.dart';
import 'package:audio_cult/app/data_source/models/requests/my_diary_event_request.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';
import '../../../utils/debouncer.dart';

class MyDiaryBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final formatStr = 'yyyy-MM-dd';
  final _myDiaryEventRequest = MyDiaryEventRequest();
  final _debouncer = Debouncer(milliseconds: 1500);
  List<EventViewWrapper>? _eventViews;
  List<EventViewWrapper> get eventViews => _eventViews ?? [];
  int get numberOfItems => 100;
  bool? _isScrollToTop;
  CancelToken? _cancel;

  MyDiaryEventView? get currentEventView => _eventViews?.firstWhereOrNull((view) {
        return view.isSelected == true;
      })?.view;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  String? get appLanguageId => _prefProvider.languageId;

  MyDiaryBloc(this._appRepository, this._prefProvider);

  final _dateTimeInRangeStreamController = StreamController<Tuple2<DateTime?, DateTime?>>.broadcast();
  Stream<Tuple2<DateTime?, DateTime?>> get dateTimeInRangeStream => _dateTimeInRangeStreamController.stream;

  final _myEventsStreamController = StreamController<BlocState<List<EventResponse>>>.broadcast();
  Stream<BlocState<List<EventResponse>>> get myEventsStream => _myEventsStreamController.stream;

  final _viewScrollStreamController = StreamController<bool>.broadcast();
  Stream<bool> get viewScrollStream => _viewScrollStreamController.stream;

  final _eventViewStreamController = StreamController<List<EventViewWrapper>>.broadcast();
  Stream<List<EventViewWrapper>> get eventViewStream => _eventViewStreamController.stream;

  void initMetadataOfEventView(BuildContext context) {
    _eventViews = [
      EventViewWrapper()
        ..view = MyDiaryEventView.all
        ..isSelected = true,
      EventViewWrapper()..view = MyDiaryEventView.notAttending,
      EventViewWrapper()..view = MyDiaryEventView.attending,
      EventViewWrapper()..view = MyDiaryEventView.mayAttend,
    ];
    _eventViewStreamController.sink.add(_eventViews!);
  }

  void dateTimeRangeOnChanged({required DateTime? startDate, required DateTime? endDate}) {
    _dateTimeInRangeStreamController.sink.add(Tuple2(startDate, endDate));
    if (startDate == null) return;
    _myDiaryEventRequest.startDate = DateFormat(formatStr).format(startDate);
    _myDiaryEventRequest.endDate = DateFormat(formatStr).format(endDate ?? startDate);
    _debouncer.run(loadEventsWithParams);
  }

  void loadEventsWithParams() async {
    showOverLayLoading();
    _cancel?.cancel();
    _cancel = CancelToken();
    final result = await _appRepository.getMyDiaryEvents(_myDiaryEventRequest, cancel: _cancel);
    result.fold((result) {
      _myEventsStreamController.sink.add(BlocState.success(result));
      hideOverlayLoading();
    }, (exception) {
      _myEventsStreamController.sink.add(const BlocState.success([]));
      hideOverlayLoading();
    });
  }

  void loadInitialEvents() {
    _myDiaryEventRequest.startDate = DateFormat(formatStr).format(DateTime.now());
    _myDiaryEventRequest.endDate = DateFormat(formatStr).format(DateTime.now());
    loadEventsWithParams();
  }

  void filterEventsByView(EventViewWrapper eventView) {
    final previousIndex = _eventViews?.indexWhere((element) => element.isSelected);
    final index = _eventViews?.indexWhere((element) => element == eventView);
    if (previousIndex != null && previousIndex >= 0 && previousIndex < (_eventViews?.length ?? 0)) {
      _eventViews?[previousIndex].isSelected = false;
    }
    if (index != null && index >= 0 && index < (_eventViews?.length ?? 0)) {
      _eventViews?[index].isSelected = true;
    }
    _myDiaryEventRequest.view = currentEventView;
    _eventViewStreamController.sink.add(_eventViews ?? []);
    loadEventsWithParams();
  }

  void viewIsScrolling(double offset) {
    if (offset > 70) {
      _viewScrollStreamController.sink.add(_isScrollToTop ?? false);
    } else {
      _viewScrollStreamController.sink.add(true);
    }
  }

  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void viewStartScrolling(bool isScrollingToTop) {
    _isScrollToTop = isScrollingToTop;
  }

  void keywordOnChanged(String keyword) {
    _myDiaryEventRequest.title = keyword;
    loadEventsWithParams();
  }
}
