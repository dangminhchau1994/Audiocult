class RegisterRequest {
  String? accessToken;
  String? valEmail;
  String? valFullName;
  String? valUserName;
  String? valPassword;
  String? valCountryIso;

  RegisterRequest({
    this.accessToken,
    this.valEmail,
    this.valFullName,
    this.valUserName,
    this.valPassword,
    this.valCountryIso,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['val[email]'] = valEmail;
    data['val[full_name]'] = valFullName;
    data['val[user_name]'] = valUserName;
    data['val[password]'] = valPassword;
    data['val[country_iso]'] = valCountryIso;
    return data;
  }
}
