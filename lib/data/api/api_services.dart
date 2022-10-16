import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/data/models/review.dart';

enum Resolution { small, medium, large }

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  String imageBaseUrl({Resolution? resolution, required String pictureId}) {
    if (resolution == Resolution.medium) {
      return "$_baseUrl/images/medium/$pictureId";
    } else if (resolution == Resolution.large) {
      return "$_baseUrl/images/large/$pictureId";
    }
    return "$_baseUrl/images/small/$pictureId";
  }

  Future<RestaurantsModel> restaurantList(String? keyword) async {
    http.Response response;

    if (keyword != null) {
      response = await http.get(Uri.parse("$_baseUrl/search?q=$keyword"));
    } else {
      response = await http.get(Uri.parse("$_baseUrl/list"));
    }

    if (response.statusCode == 200) {
      return RestaurantsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetailModel> restaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetailModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<ReviewModel> addReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/review'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{'id': id, 'name': name, 'review': review},
      ),
    );

    if (response.statusCode == 201) {
      return ReviewModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception('Failed to create review.');
    }
  }
}
