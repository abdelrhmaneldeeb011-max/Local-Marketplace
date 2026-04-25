import 'footerButtons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Customerhomefooter extends StatefulWidget {
  const Customerhomefooter({super.key});

  @override
  State<Customerhomefooter> createState() => _CustomerhomefooterState();
}

class _CustomerhomefooterState extends State<Customerhomefooter> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Footerbuttons(
              icon: const Icon(Icons.home),
              textButton: 'Home'.tr(),
              color: Colors.deepOrange,
            ),
            Footerbuttons(
              icon: const Icon(Icons.shopping_cart, color: Colors.grey),
              textButton: 'Cart'.tr(),
              color: Colors.grey,
            ),
            Footerbuttons(
              icon: const Icon(Icons.receipt_long, color: Colors.grey),
              textButton: 'Orders'.tr(),
              color: Colors.grey,
            ),
            Footerbuttons(
              icon: const Icon(Icons.person, color: Colors.grey),
              textButton: 'Profile'.tr(),
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }
}
