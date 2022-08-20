// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_template_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageTemplateResponse _$PageTemplateResponseFromJson(
        Map<String, dynamic> json) =>
    PageTemplateResponse()
      ..countryISO = json['country_iso'] as String?
      ..genderId = json['gender'] as String?
      ..listOfGenders = (json['gender_list'] as List<dynamic>?)
          ?.map((e) => Gender.fromJson(e as Map<String, dynamic>))
          .toList()
      ..genderText = (json['custom_gender'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..cityLocation = json['city_location'] as String?
      ..postalCode = json['postal_code'] as String?
      ..birthday = json['birthday'] as String?
      ..email = json['email'] as String?
      ..latPin = json['ac_page_lat_pin'] as String?
      ..lngPin = json['ac_page_long_pin'] as String?
      ..pageTemplates = (json['page_template'] as List<dynamic>?)
          ?.map((e) => AtlasCategory.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userGroupId = json['user_group_id'] as String?;

Map<String, dynamic> _$PageTemplateResponseToJson(
        PageTemplateResponse instance) =>
    <String, dynamic>{
      'country_iso': instance.countryISO,
      'gender': instance.genderId,
      'gender_list': instance.listOfGenders,
      'custom_gender': instance.genderText,
      'city_location': instance.cityLocation,
      'postal_code': instance.postalCode,
      'birthday': instance.birthday,
      'email': instance.email,
      'ac_page_lat_pin': instance.latPin,
      'ac_page_long_pin': instance.lngPin,
      'page_template': instance.pageTemplates,
      'user_group_id': instance.userGroupId,
    };

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender()
  ..id = json['id'] as int?
  ..phrase = json['phrase'] as String?;

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'id': instance.id,
      'phrase': instance.phrase,
    };
