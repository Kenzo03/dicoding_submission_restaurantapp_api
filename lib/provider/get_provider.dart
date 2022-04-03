// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:flutter/foundation.dart';

import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.getRestaurants();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } on SocketException {
      _state = ResultState.NoConnection;
      notifyListeners();
      return _message = 'Please check your connection.';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
