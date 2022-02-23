class LoginRequest {
  String? clientId;
  String? clientSecret;
  String? grantType;
  String? username;
  String? password;

  LoginRequest({this.clientId, this.clientSecret, this.grantType, this.username, this.password});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['client_id'] = clientId;
    data['client_secret'] = clientSecret;
    data['grant_type'] = grantType;
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
