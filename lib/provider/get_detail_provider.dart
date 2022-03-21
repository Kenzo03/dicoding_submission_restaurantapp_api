// ignore_for_file: constant_identifier_names

import 'package:flutter/foundation.dart';

import '../data/model/restaurant.dart';
import '../data/api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurant(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail = await apiService.getRestaurantDetail(id);
      if (restaurantDetail.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
