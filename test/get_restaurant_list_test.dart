import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

// file which has the function
import '../lib/data/api/api_service_test.dart';
import '../lib/data/model/restaurant.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  group('getRestaurantList', () {
    test('returns 20 restaurant list when http response is successful',
        () async {
      // Mock the API call to return a json response with http status 200 Ok //
      final mockHTTPClient = MockClient((request) async {
        // Create sample response of the HTTP call //
        final response = {
          {"error": false, "message": "succes", "count": 20, "restaurants": []}
        };
        return Response(jsonEncode(response), 200);
      });
      // Check whether getNumberTrivia function returns
      // number trivia which will be a String
      expect(await ApiServiceTest.getRestaurants(mockHTTPClient),
          isA<RestaurantList>());
    });
  });
}
