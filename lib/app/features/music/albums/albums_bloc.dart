import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class AlbumsBloc extends BaseBloc<AlbumPlaylistRequest, List<Album>> {
  final AppRepository _appRepository;

  String? get currency => _appRepository.getCurrency();

  AlbumsBloc(this._appRepository);

  final _getSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _getAlbumsSubject = PublishSubject<BlocState<List<Album>>>();

  Stream<BlocState<List<Song>>> get getSongByIdStream => _getSongSubject.stream;
  Stream<BlocState<List<Album>>> get getAlbumsStream => _getAlbumsSubject.stream;

  @override
  Future<Either<List<Album>, Exception>> loadData(AlbumPlaylistRequest? params) async {
    final result = await _appRepository.getAlbums(
      params?.query ?? '',
      params?.view ?? '',
      params?.sort ?? '',
      params?.genresId ?? '',
      params?.when ?? '',
      params?.page ?? 0,
      params?.limit ?? 0,
    );
    return result;
  }
}
