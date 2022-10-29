import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/restaurant.dart';
import 'package:restaurant_app/ui/home.dart';

void main() {
  Widget createScreen() => ChangeNotifierProvider(
        create: (_) => RestaurantProvider(
          apiServices: ApiService(),
        ),
        child: const MaterialApp(
          home: HomeScreen(),
        ),
      );

  group('HomeScreen', () {
    testWidgets('should contain app name & show widget correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createScreen());

      expect(find.byType(AppBar), findsNWidgets(2));
      expect(find.text('Restopedia'), findsOneWidget);
    });
  });
}
