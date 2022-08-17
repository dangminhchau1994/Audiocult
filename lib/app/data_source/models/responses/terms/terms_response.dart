import 'package:freezed_annotation/freezed_annotation.dart';
part 'terms_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TermsResponse {
  String? pageId;
  String? text;

  TermsResponse({
    this.pageId,
    this.text,
  });

  factory TermsResponse.fromJson(Map<String, dynamic> json) => _$TermsResponseFromJson(json);
}
