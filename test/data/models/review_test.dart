import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/review.dart';

const mockResponsReview = '''
{
    "error": false,
    "message": "success",
    "customerReviews": [
        {
            "name": "test",
            "review": "makanannya lezat",
            "date": "29 Oktober 2020"
        }
    ]
}
''';

void main() {
  group('ReviewModel test', () {
    test('should return type correctly', () {
      var result = ReviewModel.fromJson(
        jsonDecode(mockResponsReview),
      );
      expect(result.runtimeType, ReviewModel);
    });

    test('should return instance class correctly', () {
      Map<String, dynamic> json = jsonDecode(mockResponsReview);
      var result = ReviewModel.fromJson(json);
      expect(result.error, false);
      expect(result.customerReviews.length, 1);
      expect(result.customerReviews[0].name, "test");
    });
  });
}
