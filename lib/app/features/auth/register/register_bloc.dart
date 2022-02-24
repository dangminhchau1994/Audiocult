import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/base_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/local/pref_provider.dart';
import '../../../data_source/models/requests/register_request.dart';
import '../../../data_source/networks/exceptions/app_exception.dart';
import '../../../data_source/repositories/app_repository.dart';

class RegisterBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final _navigateMain = PublishSubject<bool>();

  Stream<bool> get navigateMainStream => _navigateMain.stream;

  RegisterBloc(this._appRepository, this._prefProvider);
  // ignore: avoid_void_async
  void submitRegister(RegisterRequest registerRequest) async {
    showOverLayLoading();
    final resultAuthentication = await _appRepository.authentication();
    hideOverlayLoading();

    resultAuthentication.fold(
      (authentication) async {
        registerRequest.accessToken = authentication.accessToken;
        showOverLayLoading();
        final result = await _appRepository.register(registerRequest);
        hideOverlayLoading();
        result.fold(
          (data) async {
            if (data.status == StatusString.success) {
            } else {
              showError(AppException('${data.message}'));
            }
          },
          showError,
        );
      },
      showError,
    );
  }
}
