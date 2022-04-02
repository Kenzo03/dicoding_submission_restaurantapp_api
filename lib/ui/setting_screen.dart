import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/preferences_provider.dart';
import '../provider/scheduling_provider.dart';
import '../widgets/custom_dialog.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting_screen';
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(children: [
        Material(
            child: ListTile(
                title: const Text('Daily Restaurant Recommendation'),
                trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                  return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyRecommendedRestaurant(value);
                        }
                      });
                })))
      ]);
    });
  }
}
