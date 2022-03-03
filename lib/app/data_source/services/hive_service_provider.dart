import 'package:audio_cult/app/data_source/local/hive_box_name.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:hive/hive.dart';

class HiveServiceProvider {
  HiveServiceProvider();

  void saveAlbums(List<dynamic> result) async {
    await Hive.box(HiveBoxName.cache).put(HiveBoxKey.albumBox, result);
  }

  List<Album> getAlbum() {
    final result = Hive.box(HiveBoxName.cache).get(HiveBoxKey.albumBox) as List;
    return result.map((e) => Album.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }
}
