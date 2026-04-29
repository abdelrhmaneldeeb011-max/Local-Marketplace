import 'package:flutter/material.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        height: 22,
        color: Colors.deepOrange[400],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
