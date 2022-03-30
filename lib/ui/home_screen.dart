import './favorite_screen.dart';
import './profile_screen.dart';
import './promo_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import './restaurant_list.dart';
import './search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_page';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  final List<SalomonBottomBarItem> _bottomNavBarItems = [
    SalomonBottomBarItem(
      icon: const Icon(Icons.home),
      title: const Text("Home"),
      selectedColor: Colors.blue,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.discount),
      title: const Text("Promo"),
      selectedColor: Colors.red,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.favorite),
      title: const Text("Favorite"),
      selectedColor: Colors.purple,
    ),
    SalomonBottomBarItem(
      icon: const Icon(Icons.account_circle),
      title: const Text("Profile"),
      selectedColor: Colors.green,
    ),
  ];

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const PromoScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

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
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: _bottomNavIndex,
          onTap: (i) => setState(() => _bottomNavIndex = i),
          items: _bottomNavBarItems,
        )
        // BottomNavigationBar(
        //     currentIndex: _bottomNavIndex,
        //     items: _bottomNavBarItems,
        //     onTap: _onBottomNavTapped)
        );
  }
}
