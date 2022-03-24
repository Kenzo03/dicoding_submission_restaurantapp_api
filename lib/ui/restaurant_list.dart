import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Provider
import '../provider/get_provider.dart';

//Widgets
import '../widgets/blankslate.dart';
import '../widgets/restaurant_card.dart';

//UI
import './search_screen.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deresto'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, SearchScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<RestaurantProvider>(builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.result.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = state.result.restaurants[index];
                return CardRestaurant(restaurant: restaurant);
              });
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Blankslate(),
                const SizedBox(height: 8),
                Text(state.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (state.state == ResultState.NoConnection) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Blankslate(),
                const SizedBox(height: 8),
                Text(state.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Blankslate(),
                const SizedBox(height: 8),
                Text(state.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      }),
    );
  }
}
