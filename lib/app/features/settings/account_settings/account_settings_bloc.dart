import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/account_settings.dart';
import 'package:audio_cult/app/data_source/models/base_response.dart';
import 'package:audio_cult/app/data_source/models/requests/remove_account_request.dart';
import 'package:audio_cult/app/data_source/models/responses/language_response.dart';
import 'package:audio_cult/app/data_source/models/responses/timezone/timezone_response.dart';
import 'package:audio_cult/app/data_source/models/update_account_settings_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';
import 'package:audio_cult/localized_widget_wrapper/language_bloc.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/subjects.dart';
import 'package:tuple/tuple.dart';

class AccountSettingsBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  final LanguageBloc _languageBloc;
  AccountSettings? _accountSettings;
  TimeZone? _currentTimeZone;
  Language? _currentLanguage;
  List<TimeZone>? _timezones;
  List<Language>? _languages;

  final _deleteAccountSubject = PublishSubject<BaseRes>();
  Stream<BaseRes> get deleteAccountStream => _deleteAccountSubject.stream;

  final _loadProfileStreamController = StreamController<BlocState<AccountSettings?>>.broadcast();
  Stream<BlocState<AccountSettings?>> get loadProfileStream => _loadProfileStreamController.stream;

  final _updateAccountStreamController =
      StreamController<BlocState<Tuple2<UpdateAccountSettingsResponse?, bool?>>>.broadcast();
  Stream<BlocState<Tuple2<UpdateAccountSettingsResponse?, bool?>>> get updateAccountStream =>
      _updateAccountStreamController.stream;

  final _accountUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get accountUpdatedStream => _accountUpdatedStreamController.stream;

  final _passwordUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get passwordUpdatedStream => _passwordUpdatedStreamController.stream;

  final _paymentMethodUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get paymentMethodStream => _paymentMethodUpdatedStreamController.stream;

  final _loadTimeZonesStreamController = StreamController<BlocState<Tuple2<List<TimeZone>, TimeZone?>>>.broadcast();
  Stream<BlocState<Tuple2<List<TimeZone>, TimeZone?>>> get loadTimeZonesStream => _loadTimeZonesStreamController.stream;

  final _loadLanguagesStreamController = StreamController<BlocState<Tuple2<List<Language>, Language?>>>.broadcast();
  Stream<BlocState<Tuple2<List<Language>, Language?>>> get loadLanguagesStream => _loadLanguagesStreamController.stream;

  AccountSettingsBloc(
    this._appRepository,
    this._prefProvider,
    this._languageBloc,
  );

  void deleteAccount(RemoveAccountRequest request) async {
    showOverLayLoading();
    final result = await _appRepository.removeAccount(request);
    hideOverlayLoading();

    result.fold((data) {
      _deleteAccountSubject.sink.add(data);
    }, (err) {
      _deleteAccountSubject.sink.addError(err.toString());
    });
  }

  void clearProfile() {
    _appRepository.clearProfile();
  }

  void loadUserProfile() async {
    final userId = _prefProvider.currentUserId;
    if (userId?.isNotEmpty == true) {
      final result = await _appRepository.getMyUserInfo();
      result.fold(
        (myInfo) {
          _accountSettings = AccountSettings(myInfo);
          _loadProfileStreamController.sink.add(BlocState.success(_accountSettings));
          _loadAllSupportedLanguages();
          _loadAllTimeZones();
        },
        (exception) {
          _loadProfileStreamController.sink.add(BlocState.error(exception.toString()));
        },
      );
    }
  }

  void _loadAllTimeZones() async {
    final result = await _appRepository.getAllTimezones();
    result.fold(
      (l) {
        _timezones = l.timezones;
        _currentTimeZone = _timezones?.firstWhereOrNull(
          (element) => element.id == _accountSettings?.timezoneId,
        );
        _loadTimeZonesStreamController.sink.add(BlocState.success(Tuple2(
          l.timezones ?? [],
          _currentTimeZone ?? l.timezones?.first,
        )));
      },
      (r) {
        _loadTimeZonesStreamController.sink.add(BlocState.error(r.toString()));
      },
    );
  }

  Future<void> _loadAllSupportedLanguages() async {
    try {
      _languages = await _appRepository.getAllSupportedLanguages();
      _currentLanguage = _languages?.firstWhereOrNull(
        (element) => element.languageId == _accountSettings?.languageId,
      );
      _loadLanguagesStreamController.sink.add(
        BlocState.success(
          Tuple2(_languages ?? [], _currentLanguage ?? _languages?.first),
        ),
      );
    } catch (e) {
      _loadLanguagesStreamController.sink.add(BlocState.error(e.toString()));
    }
  }

  void accountSettingsDataOnChanged(AccountSettings? account) {
    final isUpdatedAccountButtonEnabled =
        _accountSettings?.fullName != account?.fullName || _accountSettings?.email != account?.email;
    _accountUpdatedStreamController.sink.add(isUpdatedAccountButtonEnabled);
    _accountSettings = account;
    final isUpdatePasswordButtonEnabled = _accountSettings?.currentPass?.isNotEmpty == true &&
        _accountSettings?.newPass?.isNotEmpty == true &&
        _accountSettings?.confirmPass?.isNotEmpty == true;
    _passwordUpdatedStreamController.sink.add(isUpdatePasswordButtonEnabled);
    final isUpdatedPaymentButtonEnabled = _accountSettings?.paypalEmail?.isNotEmpty == true;
    _paymentMethodUpdatedStreamController.sink.add(isUpdatedPaymentButtonEnabled);
  }

  void updateAccountSettings() async {
    showOverLayLoading();
    if (_accountSettings != null) {
      final shouldBackToHome = _accountSettings?.timezoneId != _currentTimeZone?.id ||
          _accountSettings?.languageId != _currentLanguage?.languageId;
      _accountSettings?.timezoneId = _currentTimeZone?.id;
      _accountSettings?.languageId = _currentLanguage?.languageId;
      final result = await _appRepository.updateAccountSettings(_accountSettings!);
      result.fold((response) {
        _appRepository.clearProfile();
        _updateAppLanguage(languageId: _accountSettings?.languageId ?? '').then((_) {
          hideOverlayLoading();
          _updateAccountStreamController.sink.add(BlocState.success(Tuple2(response, shouldBackToHome)));
        });
      }, (exception) {
        _updateAccountStreamController.sink.add(BlocState.error(exception.toString()));
        hideOverlayLoading();
      });
    }
  }

  void languageOnChanged(Language? language) {
    if (language == null) return;
    _accountUpdatedStreamController.sink.add(true);
    _currentLanguage = language;
    _loadLanguagesStreamController.sink.add(BlocState.success(Tuple2(
      _languages ?? [],
      _currentLanguage ?? _languages?.first,
    )));
  }

  void timezoneOnChanged(TimeZone? timezone) {
    if (timezone == null) return;
    _accountUpdatedStreamController.sink.add(true);
    _currentTimeZone = timezone;
    _loadTimeZonesStreamController.sink.add(BlocState.success(Tuple2(
      _timezones ?? [],
      _currentTimeZone ?? _timezones?.first,
    )));
  }

  Future<void> _updateAppLanguage({required String languageId}) async {
    _prefProvider.setAppLanguage(languageId: languageId);
    await _languageBloc.initLocalizedText();
  }
}
