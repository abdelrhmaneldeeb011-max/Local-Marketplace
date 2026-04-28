// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import '../customerHomeWidgets/widgets/categoryList.dart';
import '../customerFooter.dart';
import '../customerHomeWidgets/widgets/searchBar.dart';
import '../customerHomeWidgets/widgets/shopsView.dart';
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
      backgroundColor: Colors.white,
      appBar: MyAppBar(),

      body: Column(
        children: [
          SizedBox(height: 10),
          MySearchBar(),
          Categorylist(),
          SizedBox(height: 5),
          Shopsview(),
        ],
      ),

      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(children: [CustomerFooter(activeTabIndex: 0)]);
          },
        ),
      ],
    );
  }
}
