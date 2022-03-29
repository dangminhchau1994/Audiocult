import 'dart:io';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/create_playlist_request.dart';
import 'package:audio_cult/app/data_source/models/responses/create_playlist/create_playlist_response.dart';
import 'package:dartz/dartz.dart';

import '../../../data_source/repositories/app_repository.dart';

class CreatePlayListBloc extends BaseBloc<CreatePlayListRequest, CreatePlayListResponse> {
  final AppRepository _appRepository;

  CreatePlayListBloc(this._appRepository);

  @override
  Future<Either<CreatePlayListResponse, Exception>> loadData(CreatePlayListRequest? params) async {
    final result = await _appRepository.createPlayList(
      params?.title ?? '',
      params?.file ?? File(''),
    );
    return result;
  }
}
