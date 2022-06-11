import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:dio/dio.dart';

class UniversalSearchResultsBloc extends BaseBloc {
  final AppRepository _appRepo;
  String? _keyword;
  int litmit = 20;
  CancelToken? _cancel;

  final _searchAllStreanController = StreamController<BlocState<List<UniversalSearchItem>>>.broadcast();
  Stream<BlocState<List<UniversalSearchItem>>> get searchResultsLoadedStream => _searchAllStreanController.stream;

  UniversalSearchResultsBloc(this._appRepo);

  void keywordOnChange(String keyword, UniversalSearchView searchView) async {
    _keyword = keyword;
    loadMoreResults(1, searchView);
  }

  void loadMoreResults(int pageNumber, UniversalSearchView searchView) async {
    if (_keyword?.isNotEmpty == true) {
      if (pageNumber == 1) showOverLayLoading();
      _cancel?.cancel();
      _cancel = CancelToken();
      final result = await _appRepo.universalSearch(
        keyword: _keyword ?? '',
        page: pageNumber,
        searchView: searchView,
        limit: litmit,
        cancel: _cancel,
      );
      if (pageNumber == 1) hideOverlayLoading();
      result.fold(
        (l) => _searchAllStreanController.sink.add(BlocState.success(l?.data ?? [])),
        (r) => _searchAllStreanController.sink.add(BlocState.error(r.toString())),
      );
    } else {
      _searchAllStreanController.sink.add(const BlocState.success([]));
    }
  }
}
