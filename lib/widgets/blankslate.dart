import 'package:flutter/material.dart';

class Blankslate extends StatelessWidget {
  const Blankslate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.signal_wifi_connected_no_internet_4_outlined,
            color: Colors.grey, size: 64),
        SizedBox(height: 24),
        Text('Something went wrong, check again later.',
            style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
