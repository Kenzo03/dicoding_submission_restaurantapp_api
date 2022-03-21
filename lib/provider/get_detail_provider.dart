// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService}) {
    _fetchRestaurant(id);
  }

  late RestaurantList _restaurantList;
  late ResultState _state;
  String _message = '';
  String _id = '';

  String get message => _message;
  String get id => _id;
  RestaurantList get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      _id = id;
      notifyListeners();
      final restaurantList = await apiService.getRestaurantDetail(id);
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
