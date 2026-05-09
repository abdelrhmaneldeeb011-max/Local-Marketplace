import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({
    super.key,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.textButton,
    required this.textcolor,
    required this.onTap,
    required this.backgroundColor,
    required this.textsize,
    required this.shadowcolor,
  });
  final Icon icon;
  final double iconSize;
  final Color iconColor;
  final Color backgroundColor;
  final String textButton;
  final Color textcolor;
  final double textsize;
  final VoidCallback onTap;
  final Color shadowcolor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
          shadowColor: shadowcolor,
        ),

        icon: Icon(icon.icon, size: iconSize, color: iconColor),
        label: Builder(
          builder: (context) => Text(
            textButton.tr(),
            style: TextStyle(color: textcolor, fontSize: textsize),
          ),
        ),
      ),
    );
  }
}
