// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) => Country()
  ..name = json['name'] as String?
  ..countryISO = json['country_iso'] as String?;

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'name': instance.name,
      'country_iso': instance.countryISO,
    };

City _$CityFromJson(Map<String, dynamic> json) => City()
  ..name = json['name'] as String?
  ..nameDecoded = json['name_decoded'] as String?
  ..childID = json['child_id'] as String?;

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'name_decoded': instance.nameDecoded,
      'child_id': instance.childID,
    };
