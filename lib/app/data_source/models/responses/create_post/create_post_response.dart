import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatePostResponse {
  final dynamic feedId;

  CreatePostResponse({this.feedId});

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) => _$CreatePostResponseFromJson(json);
}
