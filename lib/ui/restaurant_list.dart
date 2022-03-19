import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/restaurant_provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, state, _) {
      if (state.state == ResultState.Loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == ResultState.HasData) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return ListTile(
                  leading: Image.network(
                      'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}'),
                  title: Text(restaurant.name),
                  subtitle: Text(restaurant.city));
            });
      } else if (state.state == ResultState.NoData) {
        return Center(child: Text(state.message));
      } else if (state.state == ResultState.Error) {
        return Center(child: Text(state.message));
      } else {
        return const Center(child: Text(''));
      }
    });
  }
}
