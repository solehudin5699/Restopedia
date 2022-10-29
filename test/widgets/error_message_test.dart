import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/widgets/error_message.dart';

void main() {
  Widget createScreen() => const MaterialApp(
        home: ErrorMessage(message: 'Error message'),
      );
  group('ErrorMessage', () {
    testWidgets('should contain Widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(createScreen());

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
