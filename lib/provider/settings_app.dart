import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/preferences/settings_app.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/datetime_helper.dart';

class SettingsAppProvider extends ChangeNotifier {
  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyUpdateActive = false;
  bool get isDailyUpdateActive => _isDailyUpdateActive;

  static int alarmId = 1;
  static Duration alarmDuration = const Duration(hours: 24);

  SettingsAppPreferences settingsAppPreferences;
  SettingsAppProvider({required this.settingsAppPreferences}) {
    _getTheme();
    _getDailyActivePreferences();
  }

  void _getTheme() async {
    _isDarkTheme = await settingsAppPreferences.isDarkTheme;
    notifyListeners();
  }

  void _getDailyActivePreferences() async {
    _isDailyUpdateActive = await settingsAppPreferences.isDailyUpdateActive;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    settingsAppPreferences.setDarkTheme(value);
    _getTheme();
  }

  Future<bool> enableDailyUpdate(bool value) async {
    settingsAppPreferences.setDailyUpdate(value);
    _getDailyActivePreferences();
    if (value) {
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        alarmDuration,
        alarmId,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
        allowWhileIdle: true,
      );
    } else {
      notifyListeners();
      return await AndroidAlarmManager.cancel(alarmId);
    }
  }
}
