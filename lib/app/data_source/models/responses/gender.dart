import 'package:freezed_annotation/freezed_annotation.dart';

part 'gender.g.dart';

@JsonSerializable()
class Gender {
  int? id;
  String? phrase;

  Gender();

  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);
}
