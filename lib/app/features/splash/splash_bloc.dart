import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

enum StatePage { init, login, main }

class SplashBloc extends BaseBloc {
  final PrefProvider _prefProvider;
  // ignore: unused_field
  final AppRepository _appRepository;
  final checkLoginSubject = BehaviorSubject<StatePage>();
  SplashBloc(this._prefProvider, this._appRepository);

  void checkScreen() {
    if (_prefProvider.isAuthenticated) {
      checkLoginSubject.sink.add(StatePage.main);
    } else {
      checkLoginSubject.sink.add(StatePage.login);
    }
  }

  @override
  void dispose() {
    checkLoginSubject.close();
  }
}
