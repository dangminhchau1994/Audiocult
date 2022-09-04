import 'package:shared_preferences/shared_preferences.dart';

class PrefNames {
  static const String accessToken = 'access_token';
  static const String userId = 'user_id';
  static const String fcmToken = 'fcm_token';
  static const String badgeCount = 'badge_count';
  static const String showBadge = 'show_badge';
  static const String languageIdKey = 'languageId';
}

class PrefProvider {
  PrefProvider(this._prefs);

  final SharedPreferences _prefs;

  bool get isAuthenticated => accessToken != null;

  String? get accessToken => _prefs.getString(PrefNames.accessToken);
  String? get fcmToken => _prefs.getString(PrefNames.fcmToken);
  String? get currentUserId => _prefs.getString(PrefNames.userId);
  int? get countBadge => _prefs.getInt(PrefNames.badgeCount);
  int? get showBadge => _prefs.getInt(PrefNames.showBadge);
  String get languageId => _prefs.getString(PrefNames.languageIdKey) ?? 'en';

  Future<bool> setFCMToken(String fcmToken) async {
    await _prefs.setString(PrefNames.fcmToken, fcmToken);
    return true;
  }

  Future<bool> setShowBadge(int showBadge) async {
    await _prefs.setInt(PrefNames.showBadge, showBadge);
    return true;
  }

  Future<bool> setCountBadge(int count) async {
    await _prefs.setInt(PrefNames.badgeCount, count);
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

  Future<bool> clearBadge() async {
    await _prefs.remove(PrefNames.badgeCount);
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

  void setAppLanguage({required String languageId}) async {
    await _prefs.setString(PrefNames.languageIdKey, languageId);
  }
}
