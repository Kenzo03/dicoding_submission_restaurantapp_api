import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> getRestaurants() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    String tempQuery = query.replaceAll(' ', '%20');
    final response =
        await http.get(Uri.parse(_baseUrl + "search?q=" + tempQuery));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search result');
    }
  }

  Future<RestaurantList> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(_baseUrl + "review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'id': id, 'name': name, 'review': review}),
    );
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
