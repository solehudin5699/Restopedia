import 'package:shared_preferences/shared_preferences.dart';

class SettingsAppPreferences {
  static const darkTheme = 'DARK_THEME';
  static const dailyUpdate = 'DAILY_UPDATE';
  final Future<SharedPreferences> sharedPreferences;

  SettingsAppPreferences({required this.sharedPreferences});

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(darkTheme) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(darkTheme, value);
  }

  Future<bool> get isDailyUpdateActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(dailyUpdate) ?? false;
  }

  void setDailyUpdate(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(dailyUpdate, value);
  }
}
