import 'dart:convert';

import 'package:audio_cult/app/data_source/models/responses/genre.dart';
import 'package:audio_cult/w_components/dropdown/common_dropdown.dart';
import 'package:flutter/services.dart';

class AssetsLocalServiceProvider {
  AssetsLocalServiceProvider();


  Future<Map<String, List<SelectMenuModel>>> getMasterDataFilter() async {
    final data = await rootBundle.loadString('assets/master_data/filter.json');
    final jsonEncode = json.decode(data);
    final result = <String, List<SelectMenuModel>>{};
    result['most_liked'] = (jsonEncode['most_liked'] as List)
        .map((e) =>
            SelectMenuModel(id: e['id'] as int, isSelected: e['is_selected'] as bool, title: e['title'] as String))
        .toList();
    result['all_time'] = (jsonEncode['all_time'] as List)
        .map((e) =>
            SelectMenuModel(id: e['id'] as int, isSelected: e['is_selected'] as bool, title: e['title'] as String))
        .toList();
    return result;
  }
}
