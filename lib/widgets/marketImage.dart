import 'package:flutter/material.dart';

class Marketimage extends StatelessWidget {
  const Marketimage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/img/MarketPhoto.png',
          width: double.infinity,
        ),
      ),
    );
  }
}
