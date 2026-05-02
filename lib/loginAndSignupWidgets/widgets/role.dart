import '../../widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Role extends StatefulWidget {
  const Role({super.key});

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  Color primaryColor = Colors.deepOrange;
  Color socondaryColor = Colors.blueGrey;
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Expanded(
            child: Button(
              textButton: 'Customer'.tr(),
              icon: const Icon(Icons.person),
              iconSize: 20,
              textsize: 14,
              backgroundColor: Colors.white,
              textcolor: primaryColor,
              iconColor: primaryColor,
              shadowcolor: Colors.deepOrange,
              onTap: () {
                setState(() {
                  primaryColor = Colors.deepOrange;
                  socondaryColor = Colors.grey;
                });
              },
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Button(
              textButton: 'Seller'.tr(),
              icon: const Icon(Icons.store),
              iconSize: 20,
              textsize: 14,
              backgroundColor: Colors.white,
              textcolor: socondaryColor,
              iconColor: socondaryColor,
              shadowcolor: Colors.deepOrange,
              onTap: () {
                setState(() {
                  primaryColor = Colors.grey;
                  socondaryColor = Colors.deepOrange;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
