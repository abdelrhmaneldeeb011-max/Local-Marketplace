import 'package:Wafrnalak/screens/customer_cart_screen.dart';
import 'package:Wafrnalak/screens/customer_home_screen.dart';
import 'package:Wafrnalak/screens/customer_orders_screen.dart';
import 'widgets/footerButtons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerFooter extends StatefulWidget {
  const CustomerFooter({super.key});

  @override
  State<CustomerFooter> createState() => _CustomerFooterState();
}

class _CustomerFooterState extends State<CustomerFooter> {
  int activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final currentLocale = context.locale;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home Button
            Footerbuttons(
              icon: Icon(
                Icons.home,
                color: activeTabIndex == 0 ? Colors.deepOrange : Colors.grey,
              ),
              textButton: 'Home'.tr(),
              color: activeTabIndex == 0 ? Colors.deepOrange : Colors.grey,
              onTap: () {
                setState(() {
                  activeTabIndex = 0;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerHomeScreen(),
                  ),
                );
              },
            ),
            // Cart Button
            Footerbuttons(
              icon: Icon(
                Icons.shopping_cart,
                color: activeTabIndex == 1 ? Colors.deepOrange : Colors.grey,
              ),
              textButton: 'Cart'.tr(),
              color: activeTabIndex == 1 ? Colors.deepOrange : Colors.grey,
              onTap: () {
                setState(() {
                  activeTabIndex = 1;
                });
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerCartScreen(),
                  ),
                );
              },
            ),
            // Orders Button
            Footerbuttons(
              icon: Icon(
                Icons.receipt_long,
                color: activeTabIndex == 2 ? Colors.deepOrange : Colors.grey,
              ),
              textButton: 'Orders'.tr(),
              color: activeTabIndex == 2 ? Colors.deepOrange : Colors.grey,
              onTap: () {
                setState(() {
                  activeTabIndex = 2;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerOrdersScreen(),
                    ),
                  );
                });
              },
            ),
            // Profile Button
            Footerbuttons(
              icon: Icon(
                Icons.person,
                color: activeTabIndex == 3 ? Colors.deepOrange : Colors.grey,
              ),
              textButton: 'Profile'.tr(),
              color: activeTabIndex == 3 ? Colors.deepOrange : Colors.grey,
              onTap: () {
                setState(() {
                  activeTabIndex = 3;
                });
              },
            ),
          ],
        );
      },
    );
  }
}
