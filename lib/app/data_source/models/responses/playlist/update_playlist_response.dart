import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_playlist_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UpdatePlaylistResponse {
  String? title;
  String? imagePath;
  String? editId;
  String? status;
  String? error;
  String? message;

  UpdatePlaylistResponse({
    this.title,
    this.imagePath,
    this.editId,
    this.error,
    this.message,
    this.status,
  });

  factory UpdatePlaylistResponse.fromJson(Map<String, dynamic> json) => _$UpdatePlaylistResponseFromJson(json);
}
