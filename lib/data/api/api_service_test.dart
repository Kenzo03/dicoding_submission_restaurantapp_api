import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';
import '../../common/constant.dart';

class ApiServiceTest {
  Future<RestaurantList> getRestaurants(http.Client client) async {
    final response = await client.get(Uri.parse(Constant.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }
}
