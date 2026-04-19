// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import '../widgets/categoryList.dart';
import '../widgets/customerHomeFooter.dart';
import '../widgets/searchBar.dart';
import '../widgets/shopsView.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    // مجرد استخدام context.locale هنا بيخلي الصفحة كلها تعيد بناء نفسها عند تغيير اللغة
    final currentLocale = context.locale;

    return Scaffold(
      appBar: MyAppBar(),

      body: Column(
        children: [
          MySearchBar(),
          const SizedBox(height: 20),
          Categorylist(),
          Shopsview(),
        ],
      ),

      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(children: [Customerhomefooter()]);
          },
        ),
      ],
    );
  }
}
