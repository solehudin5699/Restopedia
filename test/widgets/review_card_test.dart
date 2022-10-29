import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/widgets/review_card.dart';

void main() {
  Widget createScreen() => MaterialApp(
        home: ReviewCard(
          review: CustomerReviewModel(
              name: 'tester', review: 'good', date: '1/1/2022'),
        ),
      );
  group('ReviewCard', () {
    testWidgets('should contain review correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createScreen());

      expect(find.text('tester'), findsOneWidget);
      expect(find.text('good'), findsOneWidget);
      expect(find.text('1/1/2022'), findsOneWidget);
    });
  });
}
