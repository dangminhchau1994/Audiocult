import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data_source/models/requests/video_request.dart';
import '../../../data_source/models/responses/video_data.dart';
import '../../../data_source/repositories/app_repository.dart';

class ProfileVideoBloc extends BaseBloc<VideoRequest, List<Video>> {
  final AppRepository _appRepository;

  ProfileVideoBloc(this._appRepository);
  
  @override
  Future<Either<List<Video>, Exception>> loadData(VideoRequest? params) async {
    final result = await _appRepository.getVideos(params);
    return result;
  }
}
