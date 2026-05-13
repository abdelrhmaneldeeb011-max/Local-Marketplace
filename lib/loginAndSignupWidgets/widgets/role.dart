import 'package:easy_localization/easy_localization.dart';
import '../../widgets/button.dart';
import 'package:flutter/material.dart';

class Role extends StatefulWidget {
  const Role({super.key, this.onRoleChanged});
  final ValueChanged<String>? onRoleChanged;

  @override
  State<Role> createState() => _RoleState();
}

class _RoleState extends State<Role> {
  Color primaryColor = Colors.deepOrange;
  Color secondaryColor = Colors.blueGrey;

  void _selectRole(String role) {
    setState(() {
      if (role == 'customer') {
        primaryColor = Colors.deepOrange;
        secondaryColor = Colors.blueGrey;
      } else {
        primaryColor = Colors.blueGrey;
        secondaryColor = Colors.deepOrange;
      }
    });
    widget.onRoleChanged?.call(role);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Expanded(
            child: Button(
              textButton: "Customer".tr(),
              icon: const Icon(Icons.person),
              iconSize: 20,
              textsize: 14,
              backgroundColor: Colors.white,
              textcolor: primaryColor,
              iconColor: primaryColor,
              shadowcolor: Colors.deepOrange,
              onTap: () => _selectRole('customer'),
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Button(
              textButton: "Seller".tr(),
              icon: const Icon(Icons.store),
              iconSize: 20,
              textsize: 14,
              backgroundColor: Colors.white,
              textcolor: secondaryColor,
              iconColor: secondaryColor,
              shadowcolor: Colors.deepOrange,
              onTap: () => _selectRole('seller'),
            ),
          ),
        ],
      ),
    );
  }
}
