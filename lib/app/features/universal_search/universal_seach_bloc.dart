import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';
import 'package:tuple/tuple.dart';

class UniversalSearchBloc extends BaseBloc {
  UniversalSearchView? _view;
  String? _keyword;

  final _searchStreamController = StreamController<Tuple2<String, UniversalSearchView?>>.broadcast();
  Stream<Tuple2<String, UniversalSearchView?>> get searchStream => _searchStreamController.stream;

  UniversalSearchBloc();

  void keywordOnChange(String keyword) {
    _keyword = keyword;
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _view));
  }

  void searchViewOnChange(UniversalSearchView? view) {
    _view = view;
    _searchStreamController.sink.add(Tuple2(_keyword ?? '', _view));
  }

  @override
  void dispose() {
    _searchStreamController.close();
    super.dispose();
  }
}
