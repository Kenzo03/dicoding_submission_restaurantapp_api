import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/database_provider.dart';
import '../utils/result_state.dart';
import '../widgets/card_restaurant.dart';

class FavoriteScreen extends StatelessWidget {
  static const routeName = 'favorite_screen';

  const FavoriteScreen({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
