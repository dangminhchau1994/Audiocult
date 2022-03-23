import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

class MainBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final _logoutSubject = PublishSubject<bool>();
  final _profileSubject = PublishSubject<ProfileData?>();

  Stream<bool> get logoutStream => _logoutSubject.stream;
  Stream<ProfileData?> get profileStream => _profileSubject.stream;

  ProfileData? profileData;

  MainBloc(this._appRepository, this._prefProvider);

  void getUserProfile() async {
    final result = await _appRepository.getUserProfile();
    result.fold((l) => {profileData = l, _profileSubject.add(l)}, (r) {
      profileData = null;
      _profileSubject.add(null);
    });
  }

  // ignore: avoid_void_async
  void logout() async {
    showOverLayLoading();
    final result = await _appRepository.logout();
    hideOverlayLoading();
    result.fold(
      (data) async {
        await _prefProvider.clearAuthentication();
        _appRepository.clearProfile();
        _logoutSubject.add(true);
      },
      showError,
    );
  }
}
