import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import './provider/scheduling_provider.dart';

import './utils/background_service.dart';

import './utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './common/navigation.dart';

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
import './provider/database_provider.dart';
import './provider/preferences_provider.dart';

///Helper
import './data/db/database_helper.dart';
import './data/preferences/preferences_helper.dart';

//Api
import './data/api/api_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await _notificationHelper.initNotification(flutterLocalNotificationsPlugin);

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
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()))
      ],
      child: MaterialApp(
        title: 'Deresto',
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
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
