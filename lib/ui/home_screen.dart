// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/api/api_service.dart';
import './restaurant_list.dart';
// import '../widgets/platform_widgets.dart';
// import './settings_page.dart';
import '../provider/restaurant_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorite',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
    //   label: SettingsPage.settingsTitle,
    // ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<NewsProvider>(
      create: (_) => NewsProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    ChangeNotifierProvider<NewsProvider>(
      create: (_) => NewsProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    // const SettingsPage(),
  ];

  // Widget _buildAndroid(BuildContext context) {
  //   return Scaffold(
  //       body: _listWidget[_bottomNavIndex],
  //       bottomNavigationBar: BottomNavigationBar(
  //           currentIndex: _bottomNavIndex,
  //           items: _bottomNavBarItems,
  //           onTap: _onBottomNavTapped));
  // }

  // Widget _buildIos(BuildContext context) {
  //   return CupertinoTabScaffold(
  //       tabBar: CupertinoTabBar(items: _bottomNavBarItems),
  //       tabBuilder: (context, index) {
  //         return _listWidget[index];
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Deresto')),
        body: _listWidget[_bottomNavIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _bottomNavIndex,
            items: _bottomNavBarItems,
            onTap: _onBottomNavTapped));
  }
}
