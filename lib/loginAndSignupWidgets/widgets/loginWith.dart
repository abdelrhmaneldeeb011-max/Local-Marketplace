import '../../widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Loginwith extends StatefulWidget {
  const Loginwith({super.key});

  @override
  State<Loginwith> createState() => _LoginwithState();
}

class _LoginwithState extends State<Loginwith> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Button(
              icon: const Icon(Icons.facebook),
              textButton: 'facebook'.tr(),
              onTap: () {},
              iconSize: 25,
              iconColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              textcolor: Colors.black,
              textsize: 14,
              shadowcolor: Colors.deepOrange,
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Button(
              icon: const Icon(Icons.g_mobiledata),
              textButton: 'google'.tr(),
              onTap: () {},
              iconSize: 35,
              iconColor: Colors.deepOrange,
              backgroundColor: Colors.white,
              textcolor: Colors.black,
              textsize: 14,
              shadowcolor: Colors.deepOrange,
            ),
          ),
        ],
      ),
    );
  }
}
