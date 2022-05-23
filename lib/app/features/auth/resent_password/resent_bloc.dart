import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/networks/exceptions/app_exception.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:rxdart/rxdart.dart';

class ResentPasswordBloc extends BaseBloc {
  final AppRepository _appRepository;
  final _navigateMain = PublishSubject<bool>();
  Stream<bool> get navigateMainStream => _navigateMain.stream;

  ResentPasswordBloc(this._appRepository);
  Future<void> resentEmail(String email) async {
    showOverLayLoading();
    final authenticated = await _appRepository.authentication();
    hideOverlayLoading();
    authenticated.fold((l) async {
      showOverLayLoading();
      final result = await _appRepository.resentEmail(email, l.accessToken!);
      hideOverlayLoading();
      result.fold((l1) {
        if (l1!) {
          _navigateMain.add(l1);
        } else {
          showError(AppException('Error!'));
        }
      }, (r) => showError);
    }, (r) => showError);
  }
}
