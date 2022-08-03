import 'package:freezed_annotation/freezed_annotation.dart';
part 'post_reaction.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PostReactionResponse {
  int? totalLike;

  PostReactionResponse({this.totalLike});

  factory PostReactionResponse.fromJson(Map<String, dynamic> json) => _$PostReactionResponseFromJson(json);
}
