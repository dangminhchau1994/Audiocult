import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/background/background_response.dart';

class EditFeedBloc {
  final AppRepository _appRepository;

  EditFeedBloc(this._appRepository);

  final _getBackgroundSubject = PublishSubject<BlocState<List<BackgroundResponse>>>();

  Stream<BlocState<List<BackgroundResponse>>> get getBackgroundStream => _getBackgroundSubject.stream;

  void getBackgrounds() async {
    _getBackgroundSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getBackgrounds();

    result.fold((success) {
      _getBackgroundSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getBackgroundSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
