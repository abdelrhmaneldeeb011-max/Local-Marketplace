import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key? key, required this.text1, required this.text2});
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Column(
      children: [
        Text(
          text1.tr(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          text2.tr(),
          style: const TextStyle(
            fontSize: 15,
            color: const Color.fromARGB(255, 125, 125, 125),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
