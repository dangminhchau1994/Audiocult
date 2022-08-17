import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/login_request.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

class WAuthPageBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final _navigateMain = PublishSubject<String?>();

  Stream<String?> get navigateMainStream => _navigateMain.stream;

  WAuthPageBloc(this._appRepository, this._prefProvider);
  // ignore: avoid_void_async
  void getCount() async {
    showOverLayLoading();
    final result = await _appRepository.getCount();
    hideOverlayLoading();
    result.fold(
      (data) async {
        _navigateMain.sink.add(data);
      },
      showError,
    );
  }
}
