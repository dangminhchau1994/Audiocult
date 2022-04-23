import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../data_source/models/requests/profile_request.dart';
import '../../data_source/models/responses/profile_data.dart';
import '../../data_source/repositories/app_repository.dart';

class ProfileBloc extends BaseBloc<ProfileRequest, ProfileData> {
  final AppRepository _appRepository;

  ProfileBloc(this._appRepository);

  @override
  Future<Either<ProfileData, Exception>> loadData(ProfileRequest? params) async {
    final result = await _appRepository.getUserProfile(params?.userId);
    return result;
  }
}
