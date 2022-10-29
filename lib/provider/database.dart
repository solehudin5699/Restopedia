import 'package:flutter/material.dart';
import 'package:restaurant_app/common/enum.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/models/restaurants.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    getFavouriteRestaurants(null);
  }

  ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantModel> _favouriteRestaurants = [];
  List<RestaurantModel> get favouriteRestaurants => _favouriteRestaurants;

  //methods
  void getFavouriteRestaurants(String? keyword) async {
    try {
      _favouriteRestaurants = await databaseHelper.getFavouriteResto(keyword);
      if (_favouriteRestaurants.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        if (keyword != null) {
          _message = "Pencarian tidak ditemukan";
        } else {
          _message = "Belum ada restaurant yang difavoritkan";
        }
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = "Terjadi kesalahan";
      notifyListeners();
    }
  }

  void addFavouriteRestaurant(
      RestaurantModel restaurant, Function onError) async {
    try {
      await databaseHelper.insertFavouriteResto(restaurant);
      getFavouriteRestaurants(null);
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi kesalahan';
      onError('Gagal menambahkan ke favorit');
      notifyListeners();
    }
  }

  bool isFavouritedRestaurant(String id) {
    bool isFavorite =
        _favouriteRestaurants.where((element) => element.id == id).isNotEmpty;
    return isFavorite;
  }

  void removeFavouriteRestaurant(String id, Function onError) async {
    try {
      await databaseHelper.removeFavouriteResto(id);
      _favouriteRestaurants.retainWhere((e) => e.id != id);
      if (_favouriteRestaurants.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = "Belum ada restaurant yang difavoritkan";
      }
      notifyListeners();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi kesalahan';
      onError('Gagal menghapus dari favorit');
      notifyListeners();
    }
  }
}
