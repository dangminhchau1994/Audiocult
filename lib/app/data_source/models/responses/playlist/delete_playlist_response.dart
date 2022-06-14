import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_playlist_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class DeletePlayListResponse {
  String? message;

  DeletePlayListResponse({this.message});

  factory DeletePlayListResponse.fromJson(Map<String, dynamic> json) => _$DeletePlayListResponseFromJson(json);
}
