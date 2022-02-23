import '../../../base/index_walker.dart';

class LoginResponse {
  String? accessToken;
  int? expiresIn;
  String? tokenType;
  String? scope;
  String? refreshToken;

  LoginResponse({this.accessToken, this.expiresIn, this.tokenType, this.scope, this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    final iw = IW(json);
    accessToken = iw['access_token'].get();
    expiresIn = iw['expires_in'].get();
    tokenType = iw['token_type'].get();
    scope = iw['scope'].get();
    refreshToken = iw['refresh_token'].get();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiresIn;
    data['token_type'] = tokenType;
    data['scope'] = scope;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
