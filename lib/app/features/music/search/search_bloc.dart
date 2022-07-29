import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class SearchBloc extends BaseBloc {
  final AppRepository _appRepository;

  String? get currency => _appRepository.getCurrency();

  SearchBloc(this._appRepository);

  final _getPlaylistSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();
  final _getAlbumSubject = PublishSubject<BlocState<List<Album>>>();
  final _getTopSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _getMixTapSongsSubject = PublishSubject<BlocState<List<Song>>>();

  Stream<BlocState<List<PlaylistResponse>>> get getPlaylistStream => _getPlaylistSubject.stream;
  Stream<BlocState<List<Album>>> get getAlbumStream => _getAlbumSubject.stream;
  Stream<BlocState<List<Song>>> get getTopSongsStream => _getTopSongSubject.stream;
  Stream<BlocState<List<Song>>> get getMixTapSongsStream => _getMixTapSongsSubject.stream;

  void getMixTapSongs(
    String query,
    String sort,
    int page,
    int limit,
    String view,
    String type,
  ) async {
    _getMixTapSongsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getMixTapSongs(query, sort, page, limit, view, type);

    result.fold((success) {
      _getMixTapSongsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getMixTapSongsSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getTopSongs(String query, String sort, String genresId, String when, int page, int limit) async {
    _getTopSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getTopSongs(query, sort, genresId, when, page, limit);

    result.fold((success) {
      _getTopSongSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getTopSongSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getAlbums(String query, String view, int page, int limit) async {
    _getAlbumSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getAlbums(query, view, page, limit);

    result.fold((success) {
      _getAlbumSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getAlbumSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getPlaylist(String query, int page, int limit, String sort, int getAll) async {
    _getPlaylistSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getPlaylists(query, page, limit, sort, getAll);

    result.fold((success) {
      _getPlaylistSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getPlaylistSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
