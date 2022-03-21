import 'package:freezed_annotation/freezed_annotation.dart';

part 'reaction_icon_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReactionIconResponse {
  String? iconId;
  String? name;
  String? timeStamp;
  String? ordering;
  String? imagePath;
  String? isDefault;
  String? color;

  ReactionIconResponse({
    this.iconId,
    this.name,
    this.timeStamp,
    this.ordering,
    this.imagePath,
    this.isDefault,
    this.color,
  });

  factory ReactionIconResponse.fromJson(Map<String, dynamic> json) => _$ReactionIconResponseFromJson(json);
}
