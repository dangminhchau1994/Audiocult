// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_template_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageTemplateResponse _$PageTemplateResponseFromJson(
        Map<String, dynamic> json) =>
    PageTemplateResponse()
      ..countryISO = json['country_iso'] as String?
      ..gender = $enumDecodeNullable(_$GenderEnumMap, json['gender'])
      ..genderText = (json['custom_gender'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..cityLocation = json['city_location'] as String?
      ..postalCode = json['postal_code'] as String?
      ..birthday = json['birthday'] as String?
      ..email = json['email'] as String?
      ..latPin = json['ac_page_lat_pin'] as String?
      ..lngPin = json['ac_page_long_pin'] as String?
      ..userGroupId = json['user_group_id'] as String?;

Map<String, dynamic> _$PageTemplateResponseToJson(
        PageTemplateResponse instance) =>
    <String, dynamic>{
      'country_iso': instance.countryISO,
      'gender': _$GenderEnumMap[instance.gender],
      'custom_gender': instance.genderText,
      'city_location': instance.cityLocation,
      'postal_code': instance.postalCode,
      'birthday': instance.birthday,
      'email': instance.email,
      'ac_page_lat_pin': instance.latPin,
      'ac_page_long_pin': instance.lngPin,
      'user_group_id': instance.userGroupId,
    };

const _$GenderEnumMap = {
  Gender.none: '0',
  Gender.male: '1',
  Gender.female: '2',
  Gender.alien: '3',
  Gender.panda: '4',
  Gender.custom: '127',
};
