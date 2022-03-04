import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class DiscoverBloc extends BaseBloc {
  final AppRepository _appRepository;

  DiscoverBloc(this._appRepository);

  final _getTopSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _getSongOfDaySubject = PublishSubject<BlocState<Song>>();
  final _getMixTapSongsSubject = PublishSubject<BlocState<List<Song>>>();
  final _getAlbumSubject = PublishSubject<BlocState<List<Album>>>();
  final _getPlaylistSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();

  Stream<BlocState<List<Song>>> get getTopSongsStream => _getTopSongSubject.stream;
  Stream<BlocState<Song>> get getSongOfDayStream => _getSongOfDaySubject.stream;
  Stream<BlocState<List<Song>>> get getMixTapSongsStream => _getMixTapSongsSubject.stream;
  Stream<BlocState<List<Album>>> get getAlbumStream => _getAlbumSubject.stream;
  Stream<BlocState<List<PlaylistResponse>>> get getPlaylistStream => _getPlaylistSubject.stream;

  void getTopSongs(String sort, int page, int limit) async {
    _getTopSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getTopSongs(sort, page, limit);

    result.fold((success) {
      _getTopSongSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getTopSongSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getMixTapSongs(
    String sort,
    int page,
    int limit,
    String view,
    String type,
  ) async {
    _getMixTapSongsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getMixTapSongs(sort, page, limit, view, type);

    result.fold((success) {
      _getMixTapSongsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getMixTapSongsSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getAlbums(String view, int page, int limit) async {
    _getAlbumSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getAlbums(view, page, limit);

    result.fold((success) {
      _getAlbumSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getAlbumSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getSongOfDay() async {
    _getSongOfDaySubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongOfDay();

    result.fold((success) {
      _getSongOfDaySubject.sink.add(BlocState.success(success));
    }, (error) {
      _getSongOfDaySubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getPlaylist(int page, int limit, String sort, int getAll) async {
    _getPlaylistSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getPlaylists(page, limit, sort, getAll);

    result.fold((success) {
      _getPlaylistSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getPlaylistSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
