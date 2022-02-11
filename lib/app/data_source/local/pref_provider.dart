import 'package:shared_preferences/shared_preferences.dart';

class PrefNames {
  static const String accessToken = 'access_token';
}

class PrefProvider {
  PrefProvider(this._prefs);

  final SharedPreferences _prefs;

  bool get isAuthenticated => accessToken != null;

  String? get accessToken => _prefs.getString(PrefNames.accessToken);

  Future<bool> setAuthentication(String accessToken) async {
    await _prefs.setString(PrefNames.accessToken, accessToken);
    return true;
  }
}
