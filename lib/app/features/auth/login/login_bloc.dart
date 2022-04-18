import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/login_request.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/local/pref_provider.dart';
import '../../../data_source/repositories/app_repository.dart';

class LoginBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final _navigateMain = PublishSubject<bool>();

  Stream<bool> get navigateMainStream => _navigateMain.stream;

  LoginBloc(this._appRepository, this._prefProvider);
  // ignore: avoid_void_async
  void submitLogin(LoginRequest loginRequest) async {
    showOverLayLoading();
    final result = await _appRepository.login(loginRequest);
    hideOverlayLoading();
    result.fold(
      (data) async {
        await _prefProvider.setAuthentication(data.accessToken!);
        await _prefProvider.setUserId(data.userId!);
        _navigateMain.sink.add(true);
      },
      showError,
    );
  }
}
