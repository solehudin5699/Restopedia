import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/data/models/review.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
  noConnection,
  loadingAdd,
  hasDataAdd,
  errorAdd,
  noConnectionAdd,
}

class RestaurantDetailProvider extends ChangeNotifier {
  ApiService apiServices;
  String id;

  RestaurantDetailProvider({
    required this.apiServices,
    required this.id,
  }) {
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetailModel _restaurantDetail;
  late ResultState _state = ResultState.loadingAdd;
  late String _message = '';
  late ReviewModel _resultAddReview;

  String get message => _message;
  RestaurantDetailModel get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;
  ReviewModel get resultAddReview => _resultAddReview;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiServices.restaurantDetail(id);
      if (result.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Detail informasi lain tidak ditemukan";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'No Internet Connection';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = "Detail informasi lain tidak ditemukan";
    }
  }

  Future<dynamic> addReview(
      {required String id,
      required String name,
      required String review}) async {
    try {
      _state = ResultState.loadingAdd;
      notifyListeners();
      final result = await apiServices.addReview(id, name, review);
      if (result.error) {
        _state = ResultState.errorAdd;
        notifyListeners();
        return _message = "Gagal membuat review";
      } else {
        final updatedDetail = await apiServices.restaurantDetail(id);
        _state = ResultState.hasDataAdd;
        notifyListeners();
        _restaurantDetail = updatedDetail;
        _message = 'Berhasil membuat review';
        return _resultAddReview = result;
      }
    } on SocketException catch (_) {
      _state = ResultState.noConnectionAdd;
      notifyListeners();
      return _message = 'No Internet Connection';
    } catch (e) {
      _state = ResultState.errorAdd;
      notifyListeners();
      return _message = 'Terjadi kesalahan';
    }
  }
}
