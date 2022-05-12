import 'package:audio_cult/app/base/index_walker.dart';

class LanguageResponse {
  String? status;
  String? message;
  List<Language>? languages;

  LanguageResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    message = iw['message'].get();
    languages = (json['data'] as List<dynamic>).map((e) {
      return Language.fromJson(e as Map<String, dynamic>);
    }).toList();
  }
}

class Language {
  String? languageId;
  String? title;
  String? languageCode;
  String? version;

  Language.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    languageId = iw['language_id'].get();
    title = iw['title'].get();
    languageCode = iw['language_code'].get();
    version = iw['version'].get();
  }
}
