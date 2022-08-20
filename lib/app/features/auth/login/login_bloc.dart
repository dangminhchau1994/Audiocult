import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/requests/login_request.dart';
import 'package:audio_cult/localized_widget_wrapper/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data_source/local/pref_provider.dart';
import '../../../data_source/repositories/app_repository.dart';

class LoginBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final LanguageBloc _languageBloc;
  final _navigateMain = PublishSubject<bool>();

  Stream<bool> get navigateMainStream => _navigateMain.stream;

  LoginBloc(this._appRepository, this._prefProvider, this._languageBloc);
  // ignore: avoid_void_async
  void submitLogin(LoginRequest loginRequest) async {
    showOverLayLoading();
    final result = await _appRepository.login(loginRequest);
    hideOverlayLoading();
    result.fold(
      (data) async {
        await _prefProvider.setAuthentication(data.accessToken!);
        await _prefProvider.setUserId(data.userId!);
        _updateLanguageApp(complete: () {
          _navigateMain.sink.add(true);
        });
      },
      showError,
    );
  }

  void _updateLanguageApp({VoidCallback? complete}) async {
    final result = await _appRepository.getMyUserInfo();
    result.fold(
      (l) {
        if (l.languageId?.isNotEmpty == true) {
          _prefProvider.setAppLanguage(languageId: l.languageId!);
          _languageBloc.initLocalizedText().then((value) {
            complete?.call();
          });
        }
      },
      (r) {},
    );
  }
}
