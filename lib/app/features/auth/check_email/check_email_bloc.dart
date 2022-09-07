import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/networks/exceptions/app_exception.dart';
import '../../../data_source/repositories/app_repository.dart';

class CheckEmailBloc extends BaseBloc {
  final AppRepository _appRepository;
  final _navigateMain = PublishSubject<bool>();
  Stream<bool> get navigateMainStream => _navigateMain.stream;

  CheckEmailBloc(this._appRepository);
  Future<void> sendCode(String code) async {
    showOverLayLoading();
    final authenticated = await _appRepository.authentication();
    hideOverlayLoading();
    authenticated.fold((l) async {
      showOverLayLoading();
      final result = await _appRepository.sendCode(code, l.accessToken!);
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
