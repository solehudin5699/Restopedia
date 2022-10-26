import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/data/preferences/settings_app.dart';
import 'package:restaurant_app/provider/database.dart';
import 'package:restaurant_app/provider/settings_app.dart';
import 'package:restaurant_app/ui/favourite_restaurant.dart';
import 'package:restaurant_app/ui/home.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';
import 'package:restaurant_app/ui/settings.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SettingsAppProvider(
            settingsAppPreferences: SettingsAppPreferences(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'RestoPedia',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color.fromARGB(255, 255, 65, 59),
                onPrimary: const Color.fromARGB(255, 248, 246, 246),
              ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Home(),
          '/restaurantDetail': (context) => RestaurantDetail(
              data: ModalRoute.of(context)?.settings.arguments
                  as RestaurantModel),
          '/settings': (context) => const Settings(),
          '/favouriteRestaurant': (context) => const FavouriteRestaurant(),
        },
      ),
    );
  }
}
