import 'package:audio_cult/app/data_source/local/hive_box_name.dart';
import 'package:audio_cult/app/data_source/models/responses/album/album_response.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
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

  void saveProfile(dynamic profile) async {
    await Hive.box(HiveBoxName.userProfileBox).put(HiveBoxKey.profile, profile);
  }

  void clearProfile() async {
    await Hive.box(HiveBoxName.userProfileBox).clear();
  }

  ProfileData? getProfile() {
    final result = Hive.box(HiveBoxName.userProfileBox).get(HiveBoxKey.profile, defaultValue: null);
    return ProfileData.fromJson(Map<String, dynamic>.from(result as Map));
  }
}
