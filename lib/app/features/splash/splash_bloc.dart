import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/services/language_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

enum StatePage { init, login, main }

class SplashBloc extends BaseBloc {
  final PrefProvider _prefProvider;
  final LanguageProvider _localizedTextProvider;
  // ignore: unused_field
  final AppRepository _appRepository;
  final checkLoginSubject = BehaviorSubject<StatePage>();
  SplashBloc(
    this._prefProvider,
    this._appRepository,
    this._localizedTextProvider,
  );

  void checkScreen() {
    initializeLocalizedTextData().then((value) {
      if (_prefProvider.isAuthenticated) {
        checkLoginSubject.sink.add(StatePage.main);
      } else {
        checkLoginSubject.sink.add(StatePage.login);
      }
    });
  }

  Future<void> initializeLocalizedTextData() async {
    final languageId = _prefProvider.languageId;
    await _localizedTextProvider.initLocalizedText(languageId);
  }

  @override
  void dispose() {
    checkLoginSubject.close();
  }
}
