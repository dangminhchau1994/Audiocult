import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/data_source/models/responses/song/song_response.dart';

class CartResponse {
  double? grandTotal;
  double? sub_total;
  int? itemCount;
  List<Song>? songs;
  String? currency;
  double? tax;

  CartResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    grandTotal = iw['grand_total'].get();
    itemCount = iw['item_count'].get();
    songs = iw['items'].get(rawBuilder: (jsonItems) {
      final smt = jsonItems as List<dynamic>;
      return smt.map((e) => Song.fromJson(e as Map<String, dynamic>)).toList();
    });
    currency = iw['currency'].get();
    tax = iw['tax'].getDouble;
    sub_total = iw['sub_total'].getDouble;
  }
}
