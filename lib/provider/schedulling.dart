import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/datetime_helper.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  static int alarmId = 1;
  static Duration alarmDuration = const Duration(hours: 24);

  Future<bool> scheduledNotification(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
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
