import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/create_event_request.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/events/event_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class CreateEventBloc extends BaseBloc {
  final AppRepository _appRepository;
  CreateEventBloc(this._appRepository);

  final _createEventSubject = PublishSubject<BlocState<EventResponse>>();

  Stream<BlocState<EventResponse>> get createEventStream => _createEventSubject.stream;

  void createEvent(CreateEventRequest request) async {
    _createEventSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.createEvent(request);

    result.fold((success) {
      _createEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
