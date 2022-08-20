import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/services/language_provider.dart';

class LanguageBloc extends BaseBloc {
  late LanguageProvider _localizedTextProvider;
  late PrefProvider _prefProvider;

  final StreamController _localizedTextStreamController = StreamController.broadcast();
  Stream get localizeStream => _localizedTextStreamController.stream;

  LanguageBloc({
    required LanguageProvider localizedTextProvider,
    required PrefProvider prefProvider,
  }) {
    _localizedTextProvider = localizedTextProvider;
    _prefProvider = prefProvider;
    initLocalizedText();
  }

  Future<void> initLocalizedText() async {
    final languageId = _prefProvider.languageId;
    await _localizedTextProvider.initLocalizedText(languageId);
    _localizedTextStreamController.sink.add(null);
  }
}
