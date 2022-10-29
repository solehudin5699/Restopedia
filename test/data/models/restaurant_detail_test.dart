import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

String mockResponseRestaurantDetail = '''
{
    "error": false,
    "message": "success",
    "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
            {
                "name": "Italia"
            },
            {
                "name": "Modern"
            }
        ],
        "menus": {
            "foods": [
                {
                    "name": "Paket rosemary"
                },
                {
                    "name": "Toastie salmon"
                }
            ],
            "drinks": [
                {
                    "name": "Es krim"
                },
                {
                    "name": "Sirup"
                }
            ]
        },
        "rating": 4.2,
        "customerReviews": [
            {
                "name": "Ahmad",
                "review": "Tidak rekomendasi untuk pelajar!",
                "date": "13 November 2019"
            }
        ]
    }
}
''';

void main() {
  group('RestaurantDetailModel test', () {
    test('should return type correctly', () {
      var result = RestaurantDetailModel.fromJson(
        jsonDecode(mockResponseRestaurantDetail),
      );
      expect(result.runtimeType, RestaurantDetailModel);
    });

    test('should return instance class correctly', () {
      Map<String, dynamic> json = jsonDecode(mockResponseRestaurantDetail);
      var result = RestaurantDetailModel.fromJson(json);
      expect(result.message, "success");
      expect(result.restaurant.id, "rqdv5juczeskfw1e867");
      expect(result.restaurant.menus.foods.length, 2);
      expect(result.restaurant.menus.drinks.length, 2);
      expect(result.restaurant.customerReviews.length, 1);
    });
  });
}
