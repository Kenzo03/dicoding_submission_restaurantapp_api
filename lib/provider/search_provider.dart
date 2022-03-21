// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  // final String query;

  SearchRestaurantProvider({required this.apiService}) {
    fetchQueryRestaurant(query);
  }

  RestaurantSearch? _restaurantList;
  ResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  String get query => _query;
  RestaurantSearch? get result => _restaurantList;
  ResultState? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.Loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.searchRestaurant(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = ResultState.NoData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.HasData;
          notifyListeners();
          return _restaurantList = restaurantList;
        }
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
