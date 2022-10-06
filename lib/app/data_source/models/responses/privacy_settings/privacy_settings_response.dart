import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/data_source/models/responses/blocked_user.dart';
import 'package:audio_cult/app/utils/constants/app_assets.dart';

class PrivacySettingsReponse {
  String? status;
  List<PrivacySettingItem>? profile;
  List<PrivacySettingItem>? item;
  List<BlockedUser>? blockedUsers;
  String? message;

  PrivacySettingsReponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    profile = iw['data'].get();
    final profileJson = json['data']['profile'] as List<dynamic>;
    profile = profileJson.map((e) => PrivacySettingItem.fromJson(e as Map<String, dynamic>)).toList();
    final itemJson = json['data']['item'] as List<dynamic>;
    item = itemJson.map((e) => PrivacySettingItem.fromJson(e as Map<String, dynamic>)).toList();
    final blockedUserJson = json['data']['blocked_users'] as List<dynamic>;
    blockedUsers = blockedUserJson.map((e) => BlockedUser.fromJson(e as Map<String, dynamic>)).toList();
    message = iw['message'].get();
  }
}

class PrivacySettingItem {
  String? phrase;
  int? defaultValue;
  String? name;
  String? module;
  List<PrivacyOption>? options;
  String? prefix;
  String? customId;
  String? iconClass;

  PrivacySettingItem.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    phrase = iw['phrase'].get();
    defaultValue = iw['default'].getInt;
    name = iw['name'].get();
    module = iw['module'].get();
    prefix = iw['prefix'].get();
    customId = iw['custom_id'].get();
    iconClass = iw['icon_class'].get();
    final optionsJson = json['options'] as List<dynamic>;
    options = optionsJson.map((e) => PrivacyOption.fromJson(e as Map<String, dynamic>)).toList();
  }

  Map<String, dynamic>? toJson() {
    if (defaultValue == null) return null;
    return {"val['$prefix']['$name']": defaultValue};
  }
}

class PrivacyOption {
  String? phrase;
  int? value;

  PrivacyOption.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    phrase = iw['phrase'].get();
    value = iw['value'].get();
  }
}

enum PrivacySetting { community, memberOnly, noOne, everyOne }

extension PrivacySettingExtension on PrivacySetting {
  static PrivacySetting? initialize(int? value) {
    switch (value) {
      case 1:
        return PrivacySetting.community;
      case 2:
        return PrivacySetting.memberOnly;
      case 4:
        return PrivacySetting.noOne;
      case 0:
        return PrivacySetting.everyOne;
    }
    return null;
  }

  String get icon {
    switch (this) {
      case PrivacySetting.community:
        return AppAssets.icFriends;
      case PrivacySetting.memberOnly:
        return AppAssets.icSubscription;
      case PrivacySetting.noOne:
        return AppAssets.icLock;
      case PrivacySetting.everyOne:
        return AppAssets.icPublic;
    }
  }
}
