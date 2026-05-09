import '../../widgets/button.dart';
import 'package:flutter/material.dart';

class Loginbutton extends StatefulWidget {
  const Loginbutton({super.key, required this.text, this.onPressed});
  final Text text;
  final VoidCallback? onPressed;

  @override
  State<Loginbutton> createState() => _LoginbuttonState();
}

class _LoginbuttonState extends State<Loginbutton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Button(
        icon: Icon(Icons.arrow_forward),
        textButton: widget.text.data!,
        onTap:
            widget.onPressed ??
            () {
              FocusScope.of(context).unfocus();
            },
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
