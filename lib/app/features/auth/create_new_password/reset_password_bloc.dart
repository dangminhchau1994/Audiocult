import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/app_exception.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

class ResetPasswordBloc extends BaseBloc {
  final AppRepository _appRepository;
  final _navigateMain = PublishSubject<bool>();
  Stream<bool> get navigateMainStream => _navigateMain.stream;

  ResetPasswordBloc(this._appRepository);
  Future<void> resetPassword(String newPassword, String code) async {
    showOverLayLoading();
    final authenticated = await _appRepository.authentication();
    hideOverlayLoading();
    authenticated.fold((l) async {
      showOverLayLoading();
      final result = await _appRepository.resetPassword(newPassword, code, l.accessToken!);
      hideOverlayLoading();
      result.fold((l1) {
        if (l1!.isSuccess!) {
          _navigateMain.add(l1.isSuccess!);
        } else {
          showError(AppException('${l1.error['message']}'));
        }
      }, showError);
    }, showError);
  }
}
