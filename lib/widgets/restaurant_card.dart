import 'package:flutter/material.dart';
import '../ui/restaurant_detail.dart';
import '../data/model/restaurant.dart';
import '../common/constant.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Hero(
          tag: restaurant.pictureId,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
                Constant.baseUrl + 'images/medium/' + restaurant.pictureId,
                width: 100,
                fit: BoxFit.fill),
          )),
      title: Text(restaurant.name),
      subtitle: Text(restaurant.city),
      onTap: () => Navigator.pushNamed(context, RestaurantDetailPage.routeName,
          arguments: restaurant.id),
    ));
  }
}
