class RegisterRequest {
  String? accessToken;
  String? valEmail;
  String? valFullName;
  String? valUserName;
  String? valPassword;
  String? valCountryIso;
  int? valRole;
  String? valCityLocation;
  double? valRegisterLocationLat;
  double? valRegisterLocationLng;


  RegisterRequest({
    this.accessToken,
    this.valEmail,
    this.valFullName,
    this.valUserName,
    this.valPassword,
    this.valCountryIso,
    this.valRole,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    // data['access_token'] = accessToken;
    data['val[email]'] = valEmail;
    data['val[full_name]'] = valFullName;
    data['val[user_name]'] = valUserName;
    data['val[password]'] = valPassword;
    data['val[country_iso]'] = valCountryIso;
    data['val[user_group_id]'] = valRole;
    data['val[city_location]'] = valCityLocation;
    data['val[register_location_lat]'] = valRegisterLocationLat;
    data['val[register_location_lng]'] = valRegisterLocationLng;
    return data;
  }
}
