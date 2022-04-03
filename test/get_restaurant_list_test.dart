import 'package:deresto_api/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../lib/data/api/api_service_test.dart';

import 'get_restaurant_list_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurant', () {
    test(
        'returns an RestaurantList class if the http call completes successfully',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error":false,"message":"succes","count":20, "restaurants":[]}',
              200));

      expect(await getRestaurants(client), isA<RestaurantList>());
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(await getRestaurants(client), throwsException);
    });
  });
}
