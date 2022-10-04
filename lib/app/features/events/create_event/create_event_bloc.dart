import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/events/event_category_response.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class CreateEventBloc extends BaseBloc {
  final AppRepository _appRepository;
  CreateEventBloc(this._appRepository);

  final _createEventSubject = PublishSubject<BlocState<EventResponse>>();
  final _editEventSubject = PublishSubject<BlocState<EventResponse>>();
  final _getEventCategoriesSubject = PublishSubject<BlocState<List<EventCategoryResponse>>>();

  Stream<BlocState<EventResponse>> get createEventStream => _createEventSubject.stream;
  Stream<BlocState<EventResponse>> get editEventStream => _editEventSubject.stream;
  Stream<BlocState<List<EventCategoryResponse>>> get getEventCategoriesStream => _getEventCategoriesSubject.stream;

  @override
  void dispose() {
    _createEventSubject.close();
    _editEventSubject.close();
    _getEventCategoriesSubject.close();
    super.dispose();
  }

  void completeInputEventData(CreateEventRequest? request) async {
    if (request == null) return;
    _createEventSubject.sink.add(const BlocState.loading());

    if (request.isEditing) {
      update(request);
    } else {
      create(request);
    }
  }

  void create(CreateEventRequest request) async {
    final result = await _appRepository.createEvent(request);
    result.fold((success) {
      _createEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void update(CreateEventRequest request) async {
    final result = await _appRepository.updateEvent(request);
    result.fold((success) {
      if (success?.error != null) {
        _editEventSubject.sink.add(BlocState.error(success!.error['message'] as String));
        return;
      }
      final event = EventResponse.fromJson(success!.data as Map<String, dynamic>);
      _editEventSubject.sink.add(BlocState.success(event));
    }, (error) {
      _editEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getEventCategories() async {
    final result = await _appRepository.getEventCategories();

    result.fold((success) {
      _getEventCategoriesSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getEventCategoriesSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
