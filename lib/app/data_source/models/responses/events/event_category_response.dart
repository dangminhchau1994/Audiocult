import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_category_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EventCategoryResponse {
  String? categoryId;
  String? name;
  String? icon;
  String? url;
  List<dynamic>? sub;

  EventCategoryResponse({this.categoryId, this.name, this.icon, this.url, this.sub});

  factory EventCategoryResponse.fromJson(Map<String, dynamic> json) => _$EventCategoryResponseFromJson(json);
}
