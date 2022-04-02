import 'package:flutter/material.dart';
import '../ui/restaurant_detail.dart';
import '../data/model/restaurant.dart';
import '../provider/database_provider.dart';
import '../common/constant.dart';
import 'package:provider/provider.dart';
import '../common/navigation.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
                child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        Constant.baseUrl +
                            'images/medium/' +
                            restaurant.pictureId,
                        width: 100,
                        fit: BoxFit.fill),
                  )),
              title: Text(restaurant.name),
              subtitle: Text(restaurant.city),
              trailing: isFavorited
                  ? IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () => provider.removeFavorite(restaurant.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () => provider.addFavorite(restaurant),
                    ),
              onTap: () => Navigation.intentWithData(
                  RestaurantDetailPage.routeName, restaurant.id),
            ));
          });
    });
  }
}
