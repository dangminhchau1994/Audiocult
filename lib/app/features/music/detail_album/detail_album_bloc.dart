import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';
import '../../../data_source/models/responses/comment/comment_response.dart';
import '../../../data_source/models/responses/song/song_response.dart';

class DetailAlbumBloc extends BaseBloc {
  final AppRepository _appRepository;

  DetailAlbumBloc(this._appRepository);

  final _getAlbumDetailSubject = PublishSubject<BlocState<Album>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getSongSubject = PublishSubject<BlocState<List<Song>>>();

  Stream<BlocState<Album>> get getAlbumDetailStream => _getAlbumDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<Song>>> get getSongByIdStream => _getSongSubject.stream;

  void getAlbumDetail(int id) async {
    _getAlbumDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getAlbumDetail(id);

    result.fold((success) {
      _getAlbumDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getAlbumDetailSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getSongByAlbumId(int id, int page, int limit) async {
    _getSongSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongsByAlbumId(id, page, limit);

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
