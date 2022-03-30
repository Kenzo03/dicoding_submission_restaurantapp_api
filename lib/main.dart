import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//UI
import './ui/search_screen.dart';
import './ui/restaurant_detail.dart';
import './ui/restaurant_list.dart';
import './ui/home_screen.dart';
import './ui/favorite_screen.dart';
import './ui/profile_screen.dart';
import './ui/promo_screen.dart';

//Provider
import './provider/get_provider.dart';
import './provider/search_provider.dart';

//Api
import './data/api/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantProvider>(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        )
      ],
      child: MaterialApp(
        title: 'News App',
        debugShowCheckedModeBanner: false,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          PromoScreen.routeName: (context) => const PromoScreen(),
          FavoriteScreen.routeName: (context) => const FavoriteScreen(),
          ProfileScreen.routeName: (context) => const ProfileScreen(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
