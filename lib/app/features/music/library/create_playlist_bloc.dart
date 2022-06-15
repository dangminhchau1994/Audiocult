import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/base_response.dart';
import '../../../data_source/models/responses/playlist/update_playlist_response.dart';
import '../../../data_source/networks/exceptions/app_exception.dart';
import '../../../data_source/repositories/app_repository.dart';

class CreatePlayListBloc extends BaseBloc<CreatePlayListRequest, CreatePlayListResponse> {
  final AppRepository _appRepository;

  CreatePlayListBloc(this._appRepository);

  final _createListSubject = PublishSubject<BlocState<CreatePlayListResponse>>();
  final _updatePlayListSubject = PublishSubject<String>();

  Stream<BlocState<CreatePlayListResponse>> get createPlayListStream => _createListSubject.stream;
  Stream<String> get updatePlayListStream => _updatePlayListSubject.stream;

  void updatePlaylist(CreatePlayListRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.updatePlaylist(request);
    hideOverlayLoading();

    result.fold(
      (l) async {
        if (l.status == StatusString.success) {
          debugPrint('asdasd');
          _updatePlayListSubject.add(l.message ?? 'Edit success!');
        } else {
          showError(AppException(l.message));
        }
      },
      showError,
    );
  }

  void createPlayList(CreatePlayListRequest params) async {
    showOverLayLoading();
    final result = await _appRepository.createPlayList(params);
    hideOverlayLoading();

    result.fold((success) {
      _createListSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createListSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
