import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';

class DetailPlayListBloc extends BaseBloc {
  final AppRepository _appRepository;

  DetailPlayListBloc(this._appRepository);

  final _getPlayListDetailSubject = PublishSubject<BlocState<PlaylistResponse>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getSongSubject = PublishSubject<BlocState<List<Song>>>();

  Stream<BlocState<PlaylistResponse>> get getPlayListDetailStream => _getPlayListDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<Song>>> get getSongByIdStream => _getSongSubject.stream;

  void getPlayListDetail(int id) async {
    _getPlayListDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getPlayListDetail(id);

    result.fold((success) {
      _getPlayListDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getPlayListDetailSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getSongByPlayListId(int id, int page, int limit) async {
    _getSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongByPlaylistId(id, page, limit);

    result.fold((success) {
      _getSongSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getSongSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getComments(int id, String typeId, int page, int limit) async {
    _getCommentsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getComments(id, typeId, page, limit);

    result.fold((success) {
      _getCommentsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getCommentsSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
