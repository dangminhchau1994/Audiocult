import 'dart:io';
import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/repositories/app_repository.dart';

class CreatePlayListBloc extends BaseBloc<CreatePlayListRequest, CreatePlayListResponse> {
  final AppRepository _appRepository;

  CreatePlayListBloc(this._appRepository);

  final _createListSubject = PublishSubject<BlocState<CreatePlayListResponse>>();

  Stream<BlocState<CreatePlayListResponse>> get createPlayListStream => _createListSubject.stream;

  void createPlayList(CreatePlayListRequest params) async {
    _createListSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.createPlayList(params);

    result.fold((success) {
      _createListSubject.sink.add(BlocState.success(success));
    }, (error) {
      _createListSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
