import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/comment/comment_response.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/app/features/my_cart/my_cart_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/bloc_state.dart';

class DetailSongBloc extends BaseBloc {
  final AppRepository _appRepository;
  final MyCartBloc _myCartBloc;

  String? get currency => _appRepository.getCurrency();

  DetailSongBloc(this._appRepository, this._myCartBloc);

  final _getSongDetailSubject = PublishSubject<BlocState<Song>>();
  final _getCommentsSubject = PublishSubject<BlocState<List<CommentResponse>>>();
  final _getSongRecommendedSubject = PublishSubject<BlocState<List<Song>>>();
  final _addItemToCartSubject = PublishSubject<bool>();

  Stream<BlocState<Song>> get getSongDetailStream => _getSongDetailSubject.stream;
  Stream<BlocState<List<CommentResponse>>> get getCommentsStream => _getCommentsSubject.stream;
  Stream<BlocState<List<Song>>> get getSongRecommendedStream => _getSongRecommendedSubject.stream;
  Stream<bool> get addItemToCartStream => _addItemToCartSubject.stream;

  void getSongRecommended(int id) async {
    _getSongRecommendedSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongRecommended(id);

    result.fold((success) {
      _getSongRecommendedSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getSongRecommendedSubject.sink.add(BlocState.error(error.toString()));
    });
  }

  void getSongDetail(int id) async {
    _getSongDetailSubject.sink.add(const BlocState.loading());

    final result = await _appRepository.getSongDetail(id);

    result.fold((success) {
      _getSongDetailSubject.sink.add(BlocState.success(success));
    }, (error) {
      _getSongDetailSubject.sink.add(BlocState.error(error.toString()));
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

  void addSongToCart(Song song) async {
    if (_myCartBloc.isSongAlreadyAdded(song)) return;
    if (song.songId?.isNotEmpty != true) throw Exception('Song is unvailable');
    showOverLayLoading();
    final result = await _appRepository.addCartitem(song.songId!);
    hideOverlayLoading();
    result.fold((l) {
      _myCartBloc.addCartItem(song);
      _addItemToCartSubject.sink.add(true);
    }, (r) => throw Exception(r));
  }
}
