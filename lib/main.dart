import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './ui/home_screen.dart';
import './ui/search_screen.dart';
import './ui/restaurant_detail.dart';

import './provider/get_provider.dart';
import './provider/get_detail_provider.dart';
import './provider/search_provider.dart';
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
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: ApiService()),
        ),
      ],
      child: MaterialApp(
        title: 'News App',
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => const HomePage(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RestaurantDetailPage.routeName: (context) =>
              const RestaurantDetailPage(),
        },
      ),
    );
  }
}
