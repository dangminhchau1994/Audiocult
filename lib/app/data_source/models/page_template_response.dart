// ignore_for_file: no_default_cases

import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/utils/constants/gender_enum.dart';
import 'package:audio_cult/app/utils/constants/page_template_field_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_template_response.g.dart';

@JsonSerializable()
class PageTemplateResponse {
  final _dateFormat = DateFormat('dd/MM/yyyy');

  @JsonKey(name: 'country_iso')
  String? countryISO;
  Gender? gender;
  @JsonKey(name: 'city_location')
  String? cityLocation;
  @JsonKey(name: 'postal_code')
  String? postalCode;
  String? birthday;
  String? email;
  @JsonKey(ignore: true)
  List<PageTemplateCustomField>? customFields;
  @JsonKey(name: 'ac_page_lat_pin')
  String? latPin;
  @JsonKey(name: 'ac_page_long_pin')
  String? lngPin;
  @JsonKey(name: 'user_group_id')
  String? userGroupId;

  PageTemplateResponse();

  factory PageTemplateResponse.fromJson(Map<String, dynamic> json) => _$PageTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PageTemplateResponseToJson(this);

  DateTime? get dateTimeBirthDay {
    if (birthday?.isNotEmpty == true) {
      return _dateFormat.parse(birthday!);
    }
    return null;
  }

  void updateBirthday(DateTime dateTime) {
    birthday = _dateFormat.format(dateTime);
  }

  LatLng get latlngPin {
    return LatLng(
      double.parse(latPin ?? '0'),
      double.parse(lngPin ?? '0'),
    );
  }
}

class SelectableOption {
  String? key;
  String? value;
  bool? selected;

  SelectableOption.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    value = iw['value'].get();
    selected = iw['selected'].get();
  }
}

class PageTemplateCustomField {
  String? fieldId;
  String? fieldName;
  String? moduleId;
  String? productId;
  String? userGroupId;
  String? typeId;
  String? groupId;
  String? phraseVarName;
  String? typeName;
  PageTemplateFieldType? varType;
  String? isActive;
  String? isRequired;
  String? hasFeed;
  String? onSignup;
  String? ordering;
  List<String?>? customValue;
  String? value;
  String? isSearch;
  String? cgUserGroupId;
  String? cgIsActive;
  List<SelectableOption>? options;
  String? phrase;

  PageTemplateCustomField();

  factory PageTemplateCustomField.fromJson(Map<String, dynamic> json) {
    final profile = PageTemplateCustomField()
      ..fieldId = json['field_id'] as String?
      ..fieldName = json['field_name'] as String?
      ..moduleId = json['module_id'] as String?
      ..productId = json['product_id'] as String?
      ..userGroupId = json['user_group_id'] as String?
      ..typeId = json['type_id'] as String?
      ..groupId = json['group_id'] as String?
      ..phraseVarName = json['phrase_var_name'] as String?
      ..typeName = json['type_name'] as String?
      ..varType = PageTemplateFieldTypeExtension.init(json['var_type'] as String)
      ..isActive = json['is_active'] as String?
      ..isRequired = json['is_required'] as String?
      ..hasFeed = json['has_feed'] as String?
      ..onSignup = json['on_signup'] as String?
      ..ordering = json['ordering'] as String?
      ..value = json['value'] as String?
      ..isSearch = json['is_search'] as String?
      ..cgUserGroupId = json['cg_user_group_id'] as String?
      ..cgIsActive = json['cg_is_active'] as String?
      ..phrase = json['phrase'] as String?;
    if (json['customValue'].runtimeType == String) {
      profile.customValue = [json['customValue'] as String];
    } else {
      profile.customValue = (json['customValue'] as List<dynamic>?)?.map((e) => e as String?).toList();
    }
    return profile;
  }

  List<String?>? get getValues {
    switch (varType) {
      case PageTemplateFieldType.multiselect:
        return customValue;
      default:
        return [value];
    }
  }
}
