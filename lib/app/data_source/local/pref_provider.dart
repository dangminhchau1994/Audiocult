import 'package:shared_preferences/shared_preferences.dart';

class PrefNames {
  static const String accessToken = 'access_token';
  static const String userId = 'user_id';
  static const String fcmToken = 'fcm_token';
}

class PrefProvider {
  PrefProvider(this._prefs);

  final SharedPreferences _prefs;

  bool get isAuthenticated => accessToken != null;

  String? get accessToken => _prefs.getString(PrefNames.accessToken);
  String? get fcmToken => _prefs.getString(PrefNames.fcmToken);
  String? get currentUserId => _prefs.getString(PrefNames.userId);

  Future<bool> setFCMToken(String fcmToken) async {
    await _prefs.setString(PrefNames.fcmToken, fcmToken);
    return true;
  }

  Future<bool> setAuthentication(String accessToken) async {
    await _prefs.setString(PrefNames.accessToken, accessToken);
    return true;
  }

  Future<bool> setUserId(String userId) async {
    await _prefs.setString(PrefNames.userId, userId);
    return true;
  }

  Future<bool> clearAuthentication() async {
    await _prefs.remove(PrefNames.accessToken);
    return true;
  }

  Future<bool> clearUserId() async {
    await _prefs.remove(PrefNames.userId);
    return true;
  }
}
