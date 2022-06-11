import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchSuggestionBloc extends BaseBloc {
  String? _keyword;
  final _prefs = SharedPreferences.getInstance();
  final _searchHistoryStorageKey = 'SearchHistoryKey';
  final _searchHistoryMaximum = 6;
  var _searchHistory = <String>[];

  final _searchTextStreamController = StreamController<String>.broadcast();
  Stream<String> get searchTextStream => _searchTextStreamController.stream;

  final _searchHistoryStreamController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get searchHistoryStream => _searchHistoryStreamController.stream;

  SearchSuggestionBloc() {
    _prefs.then((value) {
      _searchHistory = value.getStringList(_searchHistoryStorageKey) ?? [];
      _searchHistoryStreamController.sink.add(_searchHistory);
    });
  }

  void searchTextOnChange(String keyword) async {
    if (keyword == _keyword) return;
    _keyword = keyword;
    _searchTextStreamController.sink.add(_keyword ?? '');
  }

  void search(String keyword) {
    _updateSearchHistory(keyword);
  }

  void _updateSearchHistory(String newSearch) {
    if (newSearch.isNotEmpty != true) return;
    if (_searchHistory.length >= _searchHistoryMaximum) {
      _searchHistory.removeLast();
    }
    if (_searchHistory.contains(newSearch)) {
      return;
    }
    _searchHistory.insert(0, newSearch);
    _prefs.then((value) => value.setStringList(_searchHistoryStorageKey, _searchHistory));
  }

  @override
  void dispose() {
    _searchTextStreamController.close();
    _searchHistoryStreamController.close();
    super.dispose();
  }
}
