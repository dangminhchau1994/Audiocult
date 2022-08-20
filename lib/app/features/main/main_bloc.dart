import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/data_source/models/responses/profile_data.dart';
import 'package:audio_cult/localized_widget_wrapper/language_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../data_source/local/pref_provider.dart';
import '../../data_source/repositories/app_repository.dart';

class MainBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  LanguageBloc? _languageBloc;
  final _logoutSubject = PublishSubject<bool>();
  final _profileSubject = PublishSubject<ProfileData?>();

  Stream<bool> get logoutStream => _logoutSubject.stream;
  Stream<ProfileData?> get profileStream => _profileSubject.stream;

  ProfileData? _profileData;

  ProfileData? get profileData => _profileData;

  MainBloc(
    this._appRepository,
    this._prefProvider, {
    LanguageBloc? languageBloc,
  }) {
    // TODO: remove after testing
    _languageBloc = languageBloc;
  }

  void getUserProfile() async {
    final currentUserId = _prefProvider.currentUserId;
    final result = await _appRepository.getUserProfile(currentUserId);
    result.fold(
      (l) {
        _profileData = l;
        _profileSubject.add(l);
      },
      (r) {
        _profileSubject.add(null);
      },
    );
  }

  // ignore: avoid_void_async
  void logout() async {
    showOverLayLoading();
    final result = await _appRepository.logout();
    hideOverlayLoading();
    result.fold(
      (data) async {
        await _prefProvider.clearAuthentication();
        await _prefProvider.clearUserId();
        _appRepository.clearProfile();
        _profileData = null;
        _logoutSubject.add(true);
      },
      showError,
    );
  }
}
