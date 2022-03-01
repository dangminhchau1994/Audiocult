import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/song/song_response.dart';
import '../../../data_source/repositories/app_repository.dart';

class TopSongBloc extends BaseBloc {
  final AppRepository _appRepository;

  TopSongBloc(this._appRepository);

  final _getTopSongSubject = PublishSubject<BlocState<List<Song>>>();

  Stream<BlocState<List<Song>>> get getTopSongsStream => _getTopSongSubject.stream;

  Future<List<Song>?> getTopSongs(String sort, int page, int limit) async {
    final result = await _appRepository.getTopSongs(sort, page, limit);
    return result.fold((success) {
      return success.data;
    }, (r) {
      return [];
    });
  }
}
