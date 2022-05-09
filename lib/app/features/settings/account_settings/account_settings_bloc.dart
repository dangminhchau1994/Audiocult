import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/local/pref_provider.dart';
import 'package:audio_cult/app/data_source/models/account_settings.dart';
import 'package:audio_cult/app/data_source/models/update_account_settings_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class AccountSettingsBloc extends BaseBloc {
  final AppRepository _appRepository;
  final PrefProvider _prefProvider;
  AccountSettings? _accountSettings;

  final _loadProfileStreamController = StreamController<BlocState<AccountSettings?>>.broadcast();
  Stream<BlocState<AccountSettings?>> get loadProfileStream => _loadProfileStreamController.stream;

  final _updateAccountStreamController = StreamController<BlocState<UpdateAccountSettingsResponse?>>.broadcast();
  Stream<BlocState<UpdateAccountSettingsResponse?>> get updateAccountStream => _updateAccountStreamController.stream;

  final _accountUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get accountUpdatedStream => _accountUpdatedStreamController.stream;

  final _passwordUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get passwordUpdatedStream => _passwordUpdatedStreamController.stream;

  final _paymentMethodUpdatedStreamController = StreamController<bool>.broadcast();
  Stream<bool> get paymentMethodStream => _paymentMethodUpdatedStreamController.stream;

  AccountSettingsBloc(this._appRepository, this._prefProvider) {
    loadUserProfile();
  }

  void loadUserProfile() async {
    final userId = _prefProvider.currentUserId;
    if (userId?.isNotEmpty == true) {
      final result = await _appRepository.getUserProfile(userId, data: 'general');
      result.fold(
        (profile) {
          _accountSettings = AccountSettings(profile);
          _loadProfileStreamController.sink.add(BlocState.success(_accountSettings));
        },
        (exception) {
          _loadProfileStreamController.sink.add(BlocState.error(exception.toString()));
        },
      );
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
      final result = await _appRepository.updateAccountSettings(_accountSettings!);
      result.fold((response) {
        _updateAccountStreamController.sink.add(BlocState.success(response));
        hideOverlayLoading();
      }, (exception) {
        _updateAccountStreamController.sink.add(BlocState.error(exception.toString()));
        hideOverlayLoading();
      });
    }
  }
}
