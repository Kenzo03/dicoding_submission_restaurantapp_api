import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const IconLabel(
      {Key? key, required this.icon, required this.label, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(
          width: 8,
        ),
        Text(label, style: const TextStyle(fontSize: 16))
      ],
    );
  }
}
