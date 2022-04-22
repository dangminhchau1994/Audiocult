import 'package:json_annotation/json_annotation.dart';

part 'country_response.g.dart';

@JsonSerializable()
class Country {
  String? name;
  @JsonKey(name: 'country_iso')
  String? countryISO;
  @JsonKey(ignore: true)
  List<City>? cities;

  Country();

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class City {
  String? name;
  @JsonKey(name: 'name_decoded')
  String? nameDecoded;
  @JsonKey(name: 'child_id')
  int? childID;

  City();

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  Map<String, dynamic> toJson() => _$CityToJson(this);
}
