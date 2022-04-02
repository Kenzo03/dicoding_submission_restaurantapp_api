import 'package:flutter/material.dart';

class PromoScreen extends StatelessWidget {
  static const routeName = '/promo_screen';

  const PromoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: const <Widget>[
            Icon(Icons.new_label, color: Colors.grey, size: 64),
            SizedBox(height: 24),
            Text('No new promos or offer available',
                style: TextStyle(color: Colors.grey))
          ]),
    );
  }
}
