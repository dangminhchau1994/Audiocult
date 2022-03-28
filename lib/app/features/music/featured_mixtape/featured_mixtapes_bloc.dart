import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';

import '../../../data_source/models/requests/top_song_request.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class FeaturedMixtapesBloc extends BaseBloc<TopSongRequest, List<Song>> {
  final AppRepository _appRepository;

  FeaturedMixtapesBloc(this._appRepository);

  @override
  Future<Either<List<Song>, Exception>> loadData(TopSongRequest? params) async {
    final result = await _appRepository.getMixTapSongs(
      '',
      params?.sort ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
      params?.view ?? '',
      params?.type ?? '',
    );
    return result;
  }
}
