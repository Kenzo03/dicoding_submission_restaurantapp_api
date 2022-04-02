import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';
import '../../common/constant.dart';

class ApiServiceTest {
  static Future<RestaurantList> getRestaurants(http.Client http) async {
    final response = await http.get(Uri.parse(Constant.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }
}
