// ignore_for_file: no_default_cases

import 'package:audio_cult/app/base/index_walker.dart';
import 'package:audio_cult/app/data_source/models/responses/page_template_custom_field_response.dart';
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
  @JsonKey(name: 'custom_gender')
  List<String>? genderText;
  @JsonKey(name: 'city_location')
  String? cityLocation;
  @JsonKey(name: 'postal_code')
  String? postalCode;
  String? birthday;
  String? email;
  @JsonKey(ignore: true)
  List<PageTemplateCustomFieldConfig>? customFields;
  @JsonKey(name: 'ac_page_lat_pin')
  String? latPin;
  @JsonKey(name: 'ac_page_long_pin')
  String? lngPin;
  @JsonKey(name: 'user_group_id')
  String? userGroupId;

  PageTemplateResponse();

  factory PageTemplateResponse.fromJson(Map<String, dynamic> json) => _$PageTemplateResponseFromJson(json);

  Map<String, dynamic> toJson() {
    final mappingJson = {
      'val[country_iso]': countryISO,
      'val[city_location]': cityLocation,
      'val[postal_code]': postalCode,
      'val[gender]': gender?.paramValue,
      'val[month]': dateTimeBirthDay?.month,
      'val[day]': dateTimeBirthDay?.day,
      'val[year]': dateTimeBirthDay?.year,
      'val[ac_page_lat_pin]': latPin,
      'val[ac_page_long_pin]': lngPin,
      'val[user_group_id]': userGroupId,
    };
    if (gender == Gender.custom) {
      mappingJson['val[custom_gender][]'] = genderText;
    }
    for (final field in customFields ?? <PageTemplateCustomFieldConfig>[]) {
      var key = 'custom[${field.fieldId}]';
      if (field.varType == PageTemplateFieldType.multiselect) {
        key = '$key[]';
        mappingJson[key] = field.getSelectedOptions?.map((e) => e?.key).toList();
      } else if (field.varType == PageTemplateFieldType.select || field.varType == PageTemplateFieldType.radio) {
        if (field.getSelectedOptions?.isNotEmpty == true) {
          mappingJson[key] = field.getSelectedOptions?.first?.key;
        }
      } else {
        mappingJson[key] = field.getTextValue;
      }
    }
    return mappingJson;
  }

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

  void updateLatLng(LatLng latlng) {
    latPin = latlng.latitude.toString();
    lngPin = latlng.longitude.toString();
  }
}

class SelectableOption {
  String? key;
  String? value;
  bool? selected;

  SelectableOption();

  SelectableOption.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    value = iw['value'].get();
    selected = iw['selected'].get();
  }

  @override
  String toString() {
    return 'SelectableOption: ${key} - ${value} - ${selected}';
  }
}
