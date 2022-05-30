import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_video_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UploadVideoResponse {
  String? caechId;

  UploadVideoResponse({this.caechId});

  factory UploadVideoResponse.fromJson(Map<String, dynamic> json) => _$UploadVideoResponseFromJson(json);
}
