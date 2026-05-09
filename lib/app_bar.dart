// بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';

// ignore: camel_case_types
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 30,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(30);
}
