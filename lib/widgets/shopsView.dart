import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Shopsview extends StatefulWidget {
  const Shopsview({super.key});

  @override
  State<Shopsview> createState() => _ShopsviewState();
}

class _ShopsviewState extends State<Shopsview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  'Local Shops Near You'.tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All'.tr(),
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
