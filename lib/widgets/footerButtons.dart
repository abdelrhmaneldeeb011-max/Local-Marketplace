// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';

class Footerbuttons extends StatelessWidget {
  const Footerbuttons({
    super.key,
    required this.icon,
    required this.textButton,
    required this.color,
    required this.onTap,
  });
  final Icon icon;
  final String textButton;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon.icon, color: color),
          Text(textButton, style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
