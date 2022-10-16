import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/ui/home.dart';
import 'package:restaurant_app/ui/restaurant_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            data:
                ModalRoute.of(context)?.settings.arguments as RestaurantModel),
      },
    );
  }
}
