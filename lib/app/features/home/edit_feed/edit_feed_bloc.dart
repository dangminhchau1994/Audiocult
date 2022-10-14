import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/create_post_request.dart';
import '../../../data_source/models/responses/background/background_response.dart';
import '../../../data_source/models/responses/create_post/create_post_response.dart';

class EditFeedBloc extends BaseBloc {
  final AppRepository _appRepository;

  EditFeedBloc(this._appRepository);

  final _getBackgroundSubject = PublishSubject<BlocState<List<BackgroundResponse>>>();
  final _createPostSubject = PublishSubject<BlocState<CreatePostResponse>>();
  final _createPostEventSubject = PublishSubject<BlocState<CreatePostResponse>>();

  Stream<BlocState<List<BackgroundResponse>>> get getBackgroundStream => _getBackgroundSubject.stream;
  Stream<BlocState<CreatePostResponse>> get createPostStream => _createPostSubject.stream;
  Stream<BlocState<CreatePostResponse>> get createPostEventStream => _createPostEventSubject.stream;

  void editPostStatusEvent(CreatePostRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.createPostEvent(request);
    hideOverlayLoading();

    result.fold((success) {
      _createPostEventSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createPostEventSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void editPost(CreatePostRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.createPost(request);
    hideOverlayLoading();

    result.fold((success) {
      _createPostSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createPostSubject.sink.add(BlocState.error(error.toString()));
    });
  }

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
