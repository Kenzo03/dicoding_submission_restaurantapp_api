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
      icon: Icon(Icons.home),
      title: Text("Home"),
      selectedColor: Colors.blue,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.discount),
      title: Text("Promo"),
      selectedColor: Colors.red,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.favorite),
      title: Text("Favorite"),
      selectedColor: Colors.purple,
    ),
    SalomonBottomBarItem(
      icon: Icon(Icons.settings),
      title: Text("Settings"),
      selectedColor: Colors.green,
    ),
  ];

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const RestaurantListPage(),
    const RestaurantListPage(),
    const RestaurantListPage(),
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
