import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/responses/events/event_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/models/responses/events/event_category_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class EventDetailBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;

  String? get userId => _prefProvider.currentUserId;

  EventDetailBloc(this._appRepository, this._prefProvider);

  final _getEventDetailSubject = PublishSubject<BlocState<EventResponse>>();
  final _updateEventSubject = PublishSubject<BlocState<List<EventResponse>>>();
  final _getEventCategoriesSubject = PublishSubject<BlocState<List<EventCategoryResponse>>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();

  Stream<BlocState<List<EventCategoryResponse>>> get getEventCategoriesStream => _getEventCategoriesSubject.stream;
  Stream<BlocState<EventResponse>> get getEventDetailStream => _getEventDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<EventResponse>>> get udpateEventStream => _updateEventSubject.stream;

  void getEventCategories() async {
    final result = await _appRepository.getEventCategories();

    result.fold((success) {
      _getEventCategoriesSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getEventCategoriesSubject.sink.add(BlocState.error(error.toString()));
    });
  }

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

    result.fold(displayEventDetail, (error) {
      _getEventDetailSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void displayEventDetail(EventResponse eventResponse) {
    _getEventDetailSubject.sink.add(BlocState.success(eventResponse));
  }

  void getComments(int id, String typeId, int page, int limit, String sort) async {
    _getCommentsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getComments(id, typeId, page, limit, sort);

    result.fold((success) {
      _getCommentsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getCommentsSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
