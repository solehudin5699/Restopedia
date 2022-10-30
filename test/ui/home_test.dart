import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/provider/database.dart';
import 'package:restaurant_app/provider/restaurant.dart';
import 'package:restaurant_app/ui/home.dart';

import '../data/models/restaurants_test.dart';
import 'home_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiService>()])
void main() {
  final MockApiService apiService = MockApiService();
  Widget createScreen() => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => RestaurantProvider(
              apiServices: apiService,
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => DatabaseProvider(
              databaseHelper: DatabaseHelper(),
            ),
          )
        ],
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );
  group('HomeScreen', () {
    testWidgets('should contain app name & show widget correctly',
        (WidgetTester tester) async {
      when(apiService.restaurantList(null)).thenAnswer((_) async {
        Map<String, dynamic> json = jsonDecode(mockResponseListRestaurants);
        return RestaurantsModel.fromJson(json);
      });

      await tester.pumpWidget(createScreen());

      expect(find.byType(AppBar), findsNWidgets(2));
      expect(find.text('Restopedia'), findsOneWidget);
    });
  });
}
