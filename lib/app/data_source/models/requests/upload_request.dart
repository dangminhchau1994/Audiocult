import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class UploadRequest {
  String? title;
  String? name;
  int? year;
  String? text;
  String? musicType;
  String? genreId;
  String? artistUserId;
  String? collabUserId;
  String? labelUserId;
  String? description;
  String? tags;
  String? albumId;
  String? newAlbumTitle;
  int? isFree;
  double? cost;
  String? licenseType;
  XFile? audioFile;
  XFile? songCoverFile;
  Future<Map<String, dynamic>> toJson() async {
    final data = <String, dynamic>{};
    data['val[title]'] = title;
    data['val[name]'] = name;
    data['val[year]'] = year;
    data['val[is_dj]'] = musicType;
    data['val[genre_id]'] = genreId;
    data['val[artist_user_id]'] = artistUserId;
    data['val[label_user_id]'] = labelUserId;
    data['val[collab_user_id]'] = collabUserId;
    data['val[lyrics]'] = description;
    data['val[tags]'] = tags;
    data['val[album_id]'] = albumId;
    data['val[new_album_title]'] = newAlbumTitle;
    data['val[is_free]'] = isFree;
    data['val[cost]'] = cost;
    data['val[license_type]'] = licenseType;
    data['val[text]'] = text;
    if (songCoverFile != null) {
      data['image'] = await MultipartFile.fromFile(
        songCoverFile!.path,
        filename: songCoverFile!.name,
        contentType: MediaType('image', 'jpeg'),
      );
    }
    if (audioFile != null) {
      data['file'] = await MultipartFile.fromFile(
        audioFile!.path,
        filename: audioFile!.name,
        contentType: MediaType('audio', 'mpeg'),
      );
    }
    return data;
  }
}
