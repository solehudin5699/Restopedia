import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/restaurants.dart';

const String mockResponseListRestaurants = '''
{
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
        {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
        }
    ]
}
''';

RestaurantsModel instanceRestaurants =
    RestaurantsModel.fromJson(jsonDecode(mockResponseListRestaurants));

void main() {
  group('Restaurants model test', () {
    test('should return type correctly', () {
      var result = RestaurantsModel.fromJson(
        jsonDecode(mockResponseListRestaurants),
      );
      expect(result.runtimeType, RestaurantsModel);
    });
    test('should return instance class correctly', () {
      Map<String, dynamic> json = jsonDecode(mockResponseListRestaurants);
      var result = RestaurantsModel.fromJson(json);
      expect(result.restaurants.length, 1);
      expect(result.restaurants[0].name, "Melting Pot");
      expect(result.founded, null);
    });

    test('should return map correctly', () {
      Map<String, dynamic> map = instanceRestaurants.toJson();
      expect(map["error"], false);
    });
  });
}
