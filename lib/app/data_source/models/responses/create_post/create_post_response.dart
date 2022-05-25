import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePostResponse {
  final int? feedId;

  CreatePostResponse({this.feedId});

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) => _$CreatePostResponseFromJson(json);
}
