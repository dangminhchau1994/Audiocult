import 'package:freezed_annotation/freezed_annotation.dart';
part 'reason_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReasonResponse {
  String? reasonId;
  String? message;

  ReasonResponse({
    this.reasonId,
    this.message,
  });

  factory ReasonResponse.fromJson(Map<String, dynamic> json) => _$ReasonResponseFromJson(json);
}
