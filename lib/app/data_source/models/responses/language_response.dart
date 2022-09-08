import 'package:audio_cult/app/base/index_walker.dart';

class Language {
  String? languageId;
  String? title;
  String? languageCode;
  String? locale;
  String? version;

  Language.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    languageId = iw['language_id'].get();
    title = iw['title'].get();
    languageCode = iw['language_code'].get();
    locale = iw['locale'].get();
    version = iw['version'].get();
  }
}
