import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/album/album_response.dart';
import '../../../data_source/models/responses/playlist/playlist_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class SearchBloc extends BaseBloc {
  final AppRepository _appRepository;

  SearchBloc(this._appRepository);
  
  final _getPlaylistSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();
  final _getAlbumSubject = PublishSubject<BlocState<List<Album>>>();

  Stream<BlocState<List<PlaylistResponse>>> get getPlaylistStream => _getPlaylistSubject.stream;
  Stream<BlocState<List<Album>>> get getAlbumStream => _getAlbumSubject.stream;

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
