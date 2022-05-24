// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';

import 'package:audio_cult/app/base/base_bloc.dart';
import 'package:audio_cult/app/base/bloc_state.dart';
import 'package:audio_cult/app/data_source/models/responses/blocked_user.dart';
import 'package:audio_cult/app/data_source/models/responses/privacy_settings/privacy_settings_response.dart';
import 'package:audio_cult/app/data_source/repositories/app_repository.dart';

class PrivacySettingsBloc extends BaseBloc {
  final AppRepository _appRepo;
  List<PrivacySettingItem>? _privacyProfile;
  List<PrivacySettingItem>? _privacyItem;
  List<BlockedUser>? _blockedUsers;

  final _loadPrivacyProfileStreamController = StreamController<BlocState<List<PrivacySettingItem>>>.broadcast();
  Stream<BlocState<List<PrivacySettingItem>>> get loadPrivacyProfileStream =>
      _loadPrivacyProfileStreamController.stream;

  final _loadPrivacyItemStreamController = StreamController<BlocState<List<PrivacySettingItem>>>.broadcast();
  Stream<BlocState<List<PrivacySettingItem>>> get loadPrivacyItemStream => _loadPrivacyItemStreamController.stream;

  final _loadBlockedUsersStreamController = StreamController<BlocState<List<BlockedUser>>>.broadcast();
  Stream<BlocState<List<BlockedUser>>> get loadBlockedUsersStream => _loadBlockedUsersStreamController.stream;

  final _enableUpdateProfileStreamController = StreamController<bool>.broadcast();
  Stream<bool> get enableUpdateProfileStream => _enableUpdateProfileStreamController.stream;

  final _enableUpdateAppSharingStreamController = StreamController<bool>.broadcast();
  Stream<bool> get enableUpdateAppSharingStream => _enableUpdateAppSharingStreamController.stream;

  PrivacySettingsBloc(this._appRepo);

  void loadPrivacySettings() async {
    final result = await _appRepo.getPrivacySettings();
    result.fold((l) {
      _privacyItem = l.item;
      _privacyProfile = l.profile;
      _blockedUsers = l.blockedUsers;
      _loadPrivacyProfileStreamController.sink.add(BlocState.success(_privacyProfile ?? []));
      _loadPrivacyItemStreamController.sink.add(BlocState.success(_privacyItem ?? []));
      _loadBlockedUsersStreamController.sink.add(BlocState.success(_blockedUsers ?? []));
    }, (r) {
      _loadBlockedUsersStreamController.sink.add(BlocState.error(r.toString()));
      _loadPrivacyProfileStreamController.sink.add(BlocState.error(r.toString()));
      _loadPrivacyItemStreamController.sink.add(BlocState.error(r.toString()));
    });
  }

  void repushPrivacyProfileStreamIfNeed(bool isTrue) {
    if (!isTrue) return;
    _loadPrivacyProfileStreamController.sink.add(BlocState.success(_privacyProfile ?? []));
  }

  void repushAppSharingStreamIfNeed(bool isTrue) {
    if (!isTrue) return;
    _loadPrivacyItemStreamController.sink.add(BlocState.success(_privacyItem ?? []));
  }

  void repushBlockedUsersStreamIfNeed(bool isTrue) {
    if (!isTrue) return;
    _loadBlockedUsersStreamController.sink.add(BlocState.success(_blockedUsers ?? []));
  }

  void selectOption({
    required PrivacySettingsSection section,
    required PrivacySettingItem item,
    required PrivacyOption option,
  }) {
    item.defaultValue = option.value;
    if (section == PrivacySettingsSection.profile) {
      _enableUpdateProfileStreamController.sink.add(true);
      _loadPrivacyProfileStreamController.sink.add(BlocState.success(_privacyProfile ?? []));
    } else if (section == PrivacySettingsSection.appSharing) {
      _enableUpdateAppSharingStreamController.sink.add(true);
      _loadPrivacyItemStreamController.sink.add(BlocState.success(_privacyItem ?? []));
    }
  }

  void saveDataProfileSection() async {
    showOverLayLoading();
    final result = await _appRepo.updatePrivacySettings(_privacyProfile!);
    result.fold((l) {
      hideOverlayLoading();
    }, (r) {
      hideOverlayLoading();
      showError(r);
    });
  }

  void saveDataAppSharingSection() async {
    showOverLayLoading();
    final result = await _appRepo.updatePrivacySettings(_privacyItem!);
    result.fold((l) {
      hideOverlayLoading();
    }, (r) {
      hideOverlayLoading();
      showError(r);
    });
  }

  void unblockUser(BlockedUser user) async {
    showOverLayLoading();
    final result = await _appRepo.unblockUser(user.blockUserId ?? '');
    if (result == null) {
      _blockedUsers?.removeWhere((element) => element.blockUserId == user.blockUserId);
      _loadBlockedUsersStreamController.sink.add(BlocState.success(_blockedUsers ?? []));
    } else {
      showError(result);
    }
    hideOverlayLoading();
  }
}

enum PrivacySettingsSection { profile, appSharing }
