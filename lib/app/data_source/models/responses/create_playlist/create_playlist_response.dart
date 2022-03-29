import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_playlist_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePlayListResponse {
  int? id;

  CreatePlayListResponse({
    this.id,
  });

  factory CreatePlayListResponse.fromJson(Map<String, dynamic> json) => _$CreatePlayListResponseFromJson(json);
}
