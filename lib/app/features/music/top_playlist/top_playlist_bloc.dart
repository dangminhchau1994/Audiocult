import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:dartz/dartz.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/requests/album_playlist_request.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class TopPlaylistBloc extends BaseBloc<AlbumPlaylistRequest, List<PlaylistResponse>> {
  final AppRepository _appRepository;

  TopPlaylistBloc(this._appRepository);

  final _getSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _getToplaylistSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();

  Stream<BlocState<List<Song>>> get getSongByIdStream => _getSongSubject.stream;
  Stream<BlocState<List<PlaylistResponse>>> get getAlbumsStream => _getToplaylistSubject.stream;

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

  void getSongByPlaylistId(int id, int page, int limit) async {
    _getSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongByPlaylistId(id, page, limit);

    result.fold((success) {
      _getSongSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getSongSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
