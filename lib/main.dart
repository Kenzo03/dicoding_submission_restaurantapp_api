import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//UI
import './ui/search_screen.dart';
import './ui/restaurant_detail.dart';
import './ui/restaurant_list.dart';

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
        initialRoute: RestaurantListPage.routeName,
        routes: {
          // HomePage.routeName: (context) => const HomePage(),
          SearchScreen.routeName: (context) => const SearchScreen(),
          RestaurantListPage.routeName: (context) => const RestaurantListPage(),
          RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              id: ModalRoute.of(context)?.settings.arguments as String)
        },
      ),
    );
  }
}
