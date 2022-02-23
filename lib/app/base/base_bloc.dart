import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

typedef EventAction<TEvent extends AppEvent> = Stream<AppState> Function(TEvent event);

abstract class BaseBloc<TParams, TModel> implements IBloc {
  final _loadingSubject = PublishSubject<bool>();
  final _eventSubject = PublishSubject<AppEvent>();
  final _errorSubject = PublishSubject<Exception>();
  final dictEvent = <Type, EventAction>{};
  Stream<AppState>? appStream;
  StreamSubscription? subscription;
  int? debounceTime;

  BaseBloc({this.debounceTime = 0}) {
    _registerEvents(debounceTime);
  }

  Stream<bool> get loadingStream => _loadingSubject.stream;

  Stream<Exception> get errorStream => _errorSubject.stream;

  Stream<AppEvent> get eventStream => _eventSubject.stream;

  void showOverLayLoading() {
    _loadingSubject.sink.add(true);
  }

  void hideOverlayLoading() {
    _loadingSubject.sink.add(false);
  }

  void showError(Exception e) {
    _errorSubject.sink.add(e);
  }

  // ignore: avoid_void_async
  void requestData({TParams? params}) async {
    await Future.delayed(const Duration(milliseconds: 50));
    _eventSubject.add(RequestDataEvent(params: params));
  }

  // ignore: avoid_void_async
  void forceInitEvent() async {
    _eventSubject.add(ForceInitEvent());
  }

  void _registerEvents(int? debounceTime) {
    final s = _eventSubject
        .debounceTime(Duration(milliseconds: debounceTime!))
        .switchMap<AppState>(mapEventToState)
        .startWith(InitialState())
        .publish();
    appStream = s;
    subscription = s.connect();
  }

  Future<Either<TModel, Exception>> loadData(TParams? params) {
    throw UnimplementedError();
  }

  void registerEvent<TEvent extends AppEvent>(EventAction action) {
    dictEvent[TEvent] = action;
  }

  Stream<AppState> mapEventToState(event) async* {
    if (event is RequestDataEvent) {
      Either<TModel, Exception> data;
      yield LoadingState();
      await Future.delayed(const Duration(milliseconds: 50));
      data = await loadData(event.params as TParams);
      yield* data.fold((d) async* {
        if (d is List && d.isEmpty) {
          yield EmptyDataState(params: event.params);
          return;
        }
        yield DataLoadedState(params: event.params, data: d);
      }, (r) async* {
        yield ErrorState(message: r.toString(), params: event.params);
      });
    } else if (event is ForceInitEvent) {
      yield InitialState();
    } else if (dictEvent.containsKey(event.runtimeType)) {
      final func = dictEvent[event.runtimeType];
      yield* func!(event as AppEvent);
    }
  }

  @override
  void dispose() {
    _loadingSubject.close();
    _errorSubject.close();
    _eventSubject.close();
    subscription?.cancel();
  }
}

class RequestDataEvent<TParams> extends AppEvent {
  final TParams? params;

  RequestDataEvent({this.params});
}

class ForceInitEvent extends AppEvent {
  ForceInitEvent();
}
