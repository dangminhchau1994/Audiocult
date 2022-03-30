import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/bloc_state.dart';
import '../../data_source/models/responses/playlist/playlist_response.dart';
import '../../data_source/repositories/app_repository.dart';

class PlayListDialogBloc extends BaseBloc {
  final AppRepository _appRepository;

  PlayListDialogBloc(this._appRepository);

  final _getPlaylistSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();
  final _addPlaylistSubject = PublishSubject<BlocState<PlaylistResponse>>();

  Stream<BlocState<List<PlaylistResponse>>> get getPlaylistStream => _getPlaylistSubject.stream;
  Stream<BlocState<PlaylistResponse>> get addPlaylistStream => _addPlaylistSubject.stream;

  void addToPlaylist(String playlistId, String songId) async {
    final result = await _appRepository.addToPlayList(playlistId, songId);

    result.fold((success) {
      _addPlaylistSubject.sink.add(BlocState.success(success));
    }, (error) {
      _addPlaylistSubject.sink.add(BlocState.error(error.toString()));
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
