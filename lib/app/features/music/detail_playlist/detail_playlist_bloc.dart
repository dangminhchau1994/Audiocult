import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/delete_playlist_response.dart';
import 'package:audio_cult/app/data_source/models/responses/playlist/playlist_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';
import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';

class DetailPlayListBloc extends BaseBloc {
  final AppRepository _appRepository;

  String? get currency => _appRepository.getCurrency();

  DetailPlayListBloc(this._appRepository);

  final _getPlayListDetailSubject = PublishSubject<BlocState<PlaylistResponse>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getSongSubject = PublishSubject<BlocState<List<Song>>>();
  final _deletePlayListSubject = PublishSubject<BlocState<DeletePlayListResponse>>();
  final _getPlayListRecommendedSubject = PublishSubject<BlocState<List<PlaylistResponse>>>();

  Stream<BlocState<PlaylistResponse>> get getPlayListDetailStream => _getPlayListDetailSubject.stream;
  Stream<BlocState<DeletePlayListResponse>> get deletePlayListStream => _deletePlayListSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<Song>>> get getSongByIdStream => _getSongSubject.stream;
  Stream<BlocState<List<PlaylistResponse>>> get getPlayListRecommendedStream => _getPlayListRecommendedSubject.stream;

  void deletePlayList(int id) async {
    showOverLayLoading();
    final result = await _appRepository.deletePlayList(id);
    hideOverlayLoading();

    result.fold((success) {
      _deletePlayListSubject.sink.add(BlocState.success(success));
    }, (error) {
      _deletePlayListSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getPlayListDetail(int id) async {
    _getPlayListDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getPlayListDetail(id);

    result.fold((success) {
      _getPlayListDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getPlayListDetailSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getPlayListRecommended(int id) async {
    _getPlayListRecommendedSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getPlayListRecommended(id);

    result.fold((success) {
      _getPlayListRecommendedSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getPlayListRecommendedSubject.sink.add(BlocState.error(error.toString()));
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

  void getComments(int id, String typeId, int page, int limit, String sort) async {
    _getCommentsSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getComments(id, typeId, page, limit, sort);

    result.fold((success) {
      _getCommentsSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getCommentsSubject.sink.add(BlocState.error(error.toString()));
    });
  }
}
