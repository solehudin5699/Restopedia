import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/ratings.dart';

void main() {
  Widget createScreen() => const MaterialApp(
        home: Ratings(rating: 1),
      );
  group('Ratings', () {
    testWidgets('should contain Widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createScreen());

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });
  });
}
