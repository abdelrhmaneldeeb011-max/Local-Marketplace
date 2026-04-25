// بسم الله الرحمن الرحيم //
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      toolbarHeight: 90,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset('assets/img/Wafrnalk_Logo.jpg', height: 60),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 27, right: 27),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 42,
              width: 42,
              color: Colors.black12,
              child: IconButton(
                icon: const Icon(Icons.translate),
                color: Colors.deepOrange,
                onPressed: () {
                  if (context.locale.languageCode == 'ar') {
                    context.setLocale(const Locale('en'));
                  } else {
                    context.setLocale(const Locale('ar'));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
