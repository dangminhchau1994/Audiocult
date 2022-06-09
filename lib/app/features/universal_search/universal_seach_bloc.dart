import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:tuple/tuple.dart';

class UniversalSearchBloc extends BaseBloc {
  final AppRepository _appRepo;
  UniversalSearchView? _searchView;
  String? _keyword;

  final _searchStreamController = StreamController<Tuple2<String, UniversalSearchView?>>.broadcast();
  Stream<Tuple2<String, UniversalSearchView?>> get searchStream => _searchStreamController.stream;

  final _loadSongDetailsStreamController = StreamController<BlocState<Song>>.broadcast();
  Stream<BlocState<Song>> get loadSongDetails => _loadSongDetailsStreamController.stream;

  final _searchTextStreamController = StreamController<String>.broadcast();
  Stream<String> get searchTextStream => _searchTextStreamController.stream;

  UniversalSearchBloc(this._appRepo);

  void searchTextOnChange(String keyword) async {
    if (keyword == _keyword) return;
    _keyword = keyword;
    _searchTextStreamController.sink.add(_keyword ?? '');
  }

  void startSearch(String keyword) {
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _searchView));
  }

  void searchViewOnChange(UniversalSearchView? view) {
    _searchView = view;
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _searchView));
  }

  void getSongDetails(String songId) async {
    showOverLayLoading();
    final id = int.tryParse(songId);
    if (songId.isEmpty && id == null) {
      return;
    }
    final result = await _appRepo.getSongDetail(id!);
    hideOverlayLoading();
    result.fold((l) {
      _loadSongDetailsStreamController.sink.add(BlocState.success(l));
    }, (r) {
      _loadSongDetailsStreamController.sink.add(BlocState.error(r.toString()));
    });
  }

  @override
  void dispose() {
    _searchStreamController.close();
    _searchTextStreamController.close();
    _searchStreamController.close();
    super.dispose();
  }
}
