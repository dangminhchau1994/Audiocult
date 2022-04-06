import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/event_request.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class MapBloc extends BaseBloc<EventRequest, List<EventResponse>> {
  final AppRepository _appRepository;

  MapBloc(this._appRepository);

  final _getListEventSubject = PublishSubject<BlocState<List<EventResponse>>>();

  Stream<BlocState<List<EventResponse>>> get getListEventStream => _getListEventSubject.stream;

  void getEvents(EventRequest? params) async {
    _getListEventSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getEvents(params ?? EventRequest());

    result.fold((success) {
      _getListEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getListEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  @override
  Future<Either<List<EventResponse>, Exception>> loadData(EventRequest? params) async {
    final result = await _appRepository.getEvents(params ?? EventRequest());
    return result;
  }
}
