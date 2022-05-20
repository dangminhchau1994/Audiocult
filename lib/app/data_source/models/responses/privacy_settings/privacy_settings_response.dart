import 'package:audio_cult/app/base/index_walker.dart';

class PrivacySettingsReponse {
  String? status;
  List<PrivacySettingItem>? profile;
  List<PrivacySettingItem>? item;
  String? message;

  PrivacySettingsReponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    status = iw['status'].get();
    profile = iw['data'].get();
    final profileJson = json['data']['profile'] as List<dynamic>;
    profile = profileJson.map((e) => PrivacySettingItem.fromJson(e as Map<String, dynamic>)).toList();
    final itemJson = json['data']['item'] as List<dynamic>;
    item = itemJson.map((e) => PrivacySettingItem.fromJson(e as Map<String, dynamic>)).toList();
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
