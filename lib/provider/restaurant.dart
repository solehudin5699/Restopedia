import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurants.dart';

enum ResultState { loading, noData, hasData, error, noConnection }

class RestaurantProvider extends ChangeNotifier {
  ApiService apiServices;

  RestaurantProvider({required this.apiServices}) {
    fetchRestaurantList(null);
  }

  late RestaurantsModel _restaurantList;
  late ResultState _state;
  late String _message = '';

  String get message => _message;
  RestaurantsModel get restaurantList => _restaurantList;
  ResultState get state => _state;

  Future<dynamic> fetchRestaurantList(String? keyword) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurants = await apiServices.restaurantList(keyword);
      if (restaurants.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Ups...,pencarian tidak ditemukan";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _message = 'Pencarian berhasil';
        return _restaurantList = restaurants;
      }
    } on SocketException catch (_) {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'No Internet Connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi kesalahan';
    }
  }
}
