import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

class MainBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final _logoutSubject = PublishSubject<bool>();

  Stream<bool> get logoutStream => _logoutSubject.stream;

  MainBloc(this._appRepository, this._prefProvider);

  // ignore: avoid_void_async
  void logout() async {
    showOverLayLoading();
    final result = await _appRepository.logout();
    hideOverlayLoading();
    result.fold(
      (data) async {
        await _prefProvider.clearAuthentication();
        _logoutSubject.add(true);
      },
      showError,
    );
  }
}
