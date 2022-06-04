import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class UniversalSearchBloc extends BaseBloc {
  UniversalSearchView? _searchView;
  String? _keyword;
  final _prefs = SharedPreferences.getInstance();
  var _searchHistory = <String>[];
  final _searchHistoryStorageKey = 'SearchHistoryStorageKey';
  final _searchHistoryMaximum = 6;

  final _searchStreamController = StreamController<Tuple2<String, UniversalSearchView?>>.broadcast();
  Stream<Tuple2<String, UniversalSearchView?>> get searchStream => _searchStreamController.stream;

  final _searchTextStreamController = StreamController<String>.broadcast();
  Stream<String> get searchTextStream => _searchTextStreamController.stream;

  UniversalSearchBloc() {
    _prefs.then((value) {
      _searchHistory = value.getStringList(_searchHistoryStorageKey) ?? [];
    });
  }

  void searchTextOnChange(String keyword) async {
    if (keyword == _keyword) return;
    _keyword = keyword;
    _searchTextStreamController.sink.add(_keyword ?? '');
  }

  void startSearch(String keyword) {
    _updateSearchHistory(keyword);
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _searchView));
    _prefs.then((value) => value.setStringList(_searchHistoryStorageKey, _searchHistory));
  }

  void _updateSearchHistory(String newSearch) {
    if (newSearch.isNotEmpty != true) return;
    if (_searchHistory.length >= _searchHistoryMaximum) {
      _searchHistory.removeLast();
    }
    if (_searchHistory.contains(newSearch)) {
      _searchHistory.remove(newSearch);
    }
    _searchHistory.insert(0, newSearch);
  }

  void searchViewOnChange(UniversalSearchView? view) {
    _searchView = view;
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _searchView));
  }

  List<String> getSearchHistory() {
    if (_keyword?.isNotEmpty != true) return [];
    return _searchHistory.where((element) => element.contains(_keyword ?? '')).toList();
  }

  @override
  void dispose() {
    _searchStreamController.close();
    _searchTextStreamController.close();
    super.dispose();
  }
}
