import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/album_playlist_request.dart';
import 'package:dartz/dartz.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class LibraryBloc extends BaseBloc<AlbumPlaylistRequest, List<PlaylistResponse>> {
  final AppRepository _appRepository;

  LibraryBloc(this._appRepository);

  @override
  Future<Either<List<PlaylistResponse>, Exception>> loadData(AlbumPlaylistRequest? params) async {
    final result = await _appRepository.getPlaylists(
      params?.query ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
      params?.sort ?? '',
      params?.getAll ?? 0,
    );
    return result;
  }
}
