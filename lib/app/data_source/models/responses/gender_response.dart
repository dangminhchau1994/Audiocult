import 'package:freezed_annotation/freezed_annotation.dart';

part 'gender_response.g.dart';

@JsonSerializable()
class GenderResponse {
  int? id;
  String? phrase;

  GenderResponse();

  factory GenderResponse.fromJson(Map<String, dynamic> json) => _$GenderResponseFromJson(json);
}
