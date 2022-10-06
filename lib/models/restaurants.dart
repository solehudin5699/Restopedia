import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

Future<List<Restaurant>> getRestaurants(
    BuildContext context, String? keyword) async {
  final result = await DefaultAssetBundle.of(context)
      .loadString('assets/local_restaurant.json');

  final Map<String, dynamic> parsed = await jsonDecode(result);
  final List<Restaurant> restaurants = Restaurants.fromJson(parsed).restaurants;

  if (keyword != null) {
    List<Restaurant> filtered = [];
    filtered.addAll(restaurants);
    filtered.retainWhere(
      (element) {
        return element.name.toLowerCase().contains(keyword.toLowerCase());
      },
    );
    return Future.delayed(
      const Duration(milliseconds: 500),
      () {
        return filtered;
      },
    );
  }
  return Future.delayed(
    const Duration(milliseconds: 500),
    () {
      return restaurants;
    },
  );
}

class Restaurants {
  Restaurants({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory Restaurants.fromJson(Map<String, dynamic> json) => Restaurants(
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "restaurants": List<dynamic>.from(
          restaurants.map((x) => x.toJson()),
        )
      };
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;
  Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
        menus: Menus.fromJson(json["menus"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
        "menus": menus.toJson(),
      };
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Drink>.from(
          json["foods"].map((x) => Drink.fromJson(x)),
        ),
        drinks: List<Drink>.from(
          json["drinks"].map((x) => Drink.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(
          foods.map((x) => x.toJson()),
        ),
        "drinks": List<dynamic>.from(
          drinks.map((x) => x.toJson()),
        ),
      };
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
