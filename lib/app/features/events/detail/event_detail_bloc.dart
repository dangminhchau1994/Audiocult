import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class EventDetailBloc extends BaseBloc {
  final AppRepository _appRepository;

  EventDetailBloc(this._appRepository);

  final _getEventDetailSubject = PublishSubject<BlocState<EventResponse>>();
  final _updateEventSubject = PublishSubject<BlocState<List<EventResponse>>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();

  Stream<BlocState<EventResponse>> get getEventDetailStream => _getEventDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<EventResponse>>> get udpateEventStream => _updateEventSubject.stream;

  void updateEventStatus(int id, int rsvp) async {
    final result = await _appRepository.updateEventStatus(id, rsvp);

    result.fold((success) {
      _updateEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _updateEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getEventDetail(int id) async {
    _getEventDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getEventDetail(id);

    result.fold((success) {
      _getEventDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getEventDetailSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getComments(int id, String typeId, int page, int limit) async {
    _getCommentsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getComments(id, typeId, page, limit);

    result.fold((success) {
      _getCommentsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getCommentsSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
