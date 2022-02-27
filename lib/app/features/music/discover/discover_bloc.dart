import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:rxdart/rxdart.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class DiscoverBloc extends BaseBloc {
  final AppRepository _appRepository;

  DiscoverBloc(this._appRepository);

  final _getTopSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _getMixTapSongsSubject = PublishSubject<BlocState<List<Song>>>();
  final _getAlbumSubject = PublishSubject<BlocState<List<Album>>>();

  Stream<BlocState<List<Song>>> get getTopSongsStream => _getTopSongSubject.stream;
  Stream<BlocState<List<Song>>> get getMixTapSongsStream => _getMixTapSongsSubject.stream;
  Stream<BlocState<List<Album>>> get getAlbumStream => _getAlbumSubject.stream;

  void getTopSongs(String sort, int page, int limit) async {
    _getTopSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getTopSongs(sort, limit, page);

    result.fold((success) {
      _getTopSongSubject.sink.add(BlocState.success(success.data ?? <Song>[]));
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
    _getTopSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getAlbums(view, limit, page);

    result.fold((success) {
      _getAlbumSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getAlbumSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
