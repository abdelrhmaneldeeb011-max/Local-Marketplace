import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SearchBar(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          shadowColor: WidgetStateProperty.all(Colors.grey[50]),
          hintText: 'Search'.tr(),
          hintStyle: const WidgetStatePropertyAll(
            TextStyle(color: Colors.grey),
          ),
          leading: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
