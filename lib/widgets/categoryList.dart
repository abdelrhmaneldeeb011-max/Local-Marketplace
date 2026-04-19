import 'button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({super.key});

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        children: [
          Button(
            icon: const Icon(Icons.apps),
            textButton: 'All'.tr(),
            onTap: () {},
            iconSize: 25,
            iconColor: Colors.white,
            backgroundColor: Colors.deepOrange,
            textcolor: Colors.white,
            textsize: 16,
            shadowcolor: Colors.transparent,
          ),
          const SizedBox(width: 15),
          Button(
            icon: const Icon(Icons.shopping_basket),
            textButton: 'Grocery'.tr(),
            onTap: () {},
            iconSize: 20,
            iconColor: Colors.deepOrange,
            backgroundColor: Colors.grey[300]!,
            textcolor: Colors.deepOrange,
            textsize: 14,
            shadowcolor: Colors.transparent,
          ),
          const SizedBox(width: 15),
          Button(
            icon: const Icon(Icons.bakery_dining),
            textButton: 'Bakery'.tr(),
            onTap: () {},
            iconSize: 25,
            iconColor: Colors.deepOrange,
            backgroundColor: Colors.grey[300]!,
            textcolor: Colors.deepOrange,
            textsize: 14,
            shadowcolor: Colors.transparent,
          ),
          const SizedBox(width: 15),
          Button(
            icon: const Icon(Icons.devices),
            textButton: 'Electronics'.tr(),
            onTap: () {},
            iconSize: 20,
            iconColor: Colors.deepOrange,
            backgroundColor: Colors.grey[300]!,
            textcolor: Colors.deepOrange,
            textsize: 14,
            shadowcolor: Colors.transparent,
          ),
          const SizedBox(width: 15),
          Button(
            icon: const Icon(Icons.dry_cleaning),
            textButton: 'Fashion'.tr(),
            onTap: () {},
            iconSize: 22,
            iconColor: Colors.deepOrange,
            backgroundColor: Colors.grey[300]!,
            textcolor: Colors.deepOrange,
            textsize: 14,
            shadowcolor: Colors.transparent,
          ),
          const SizedBox(width: 15),
          Button(
            icon: const Icon(Icons.local_hospital),
            textButton: 'Health'.tr(),
            onTap: () {},
            iconSize: 20,
            iconColor: Colors.deepOrange,
            backgroundColor: Colors.grey[300]!,
            textcolor: Colors.deepOrange,
            textsize: 14,
            shadowcolor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
