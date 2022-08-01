import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/top_song_request.dart';
import 'package:dartz/dartz.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class TopSongBloc extends BaseBloc<TopSongRequest, List<Song>> {
  final AppRepository _appRepository;

  String? get currency => _appRepository.getCurrency();

  TopSongBloc(this._appRepository);

  @override
  Future<Either<List<Song>, Exception>> loadData(TopSongRequest? params) async {
    final result = await _appRepository.getTopSongs(
      '',
      params?.sort ?? '',
      params?.genresId ?? '',
      params?.when ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
    );
    return result;
  }
}
