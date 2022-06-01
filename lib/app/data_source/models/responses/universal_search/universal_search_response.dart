import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/data_source/models/responses/universal_search/universal_search_result_item.dart';

class UniversalSearchReponse {
  String? status;
  List<UniversalSearchItem>? data;

  UniversalSearchReponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    data = (json['data'] as List<dynamic>)
        .map(
          (e) => UniversalSearchItem.fromJson(e as Map<String, dynamic>),
        )
        .toList();
  }
}
