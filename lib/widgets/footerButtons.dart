// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';

class Footerbuttons extends StatelessWidget {
  const Footerbuttons({
    super.key,
    required this.icon,
    required this.textButton,
    required this.color,
  });
  final Icon icon;
  final String textButton;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon.icon, color: color),
        Text(textButton, style: TextStyle(color: color)),
      ],
    );
  }
}
