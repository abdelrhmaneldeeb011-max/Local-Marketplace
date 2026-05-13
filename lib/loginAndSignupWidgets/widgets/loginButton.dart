import 'package:flutter/material.dart';
import '../../widgets/button.dart';

class Loginbutton extends StatelessWidget {
  const Loginbutton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Button(
        icon: const Icon(Icons.arrow_forward),
        textButton: text,
        onTap: onPressed != null
            ? () {
                FocusScope.of(context).unfocus();
                onPressed!();
              }
            : null,
        iconSize: 20,
        iconColor: Colors.white70,
        backgroundColor: Colors.deepOrange,
        textcolor: Colors.white,
        textsize: 14,
        shadowcolor: Colors.grey,
      ),
    );
  }
}