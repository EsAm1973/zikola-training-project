import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  static const String _isLoggedInKey = 'is_logged_in';

  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// بدل clearAll اللي كانت بتمسح كل حاجة،
  /// دلوقتي بنمسح كل key متعلق بالـ auth بس
  Future<void> clearAuthData() async {
    await _prefs.remove(_isLoggedInKey);
  }
}
