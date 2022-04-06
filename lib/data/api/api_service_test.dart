import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../model/restaurant.dart';
import '../../common/constant.dart';

class ApiServiceTest {
  final Client client;
  ApiServiceTest(this.client);

  Future<RestaurantList> getRestaurants() async {
    final response = await client.get(Uri.parse(Constant.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }
}
