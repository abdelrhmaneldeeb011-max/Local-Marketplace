import 'package:wafrnalak/screens/customer_cart_screen.dart';
import 'package:wafrnalak/screens/customer_home_screen.dart';
import 'package:wafrnalak/screens/customer_orders_screen.dart';
import 'package:wafrnalak/screens/customer_profile_screen.dart';
import 'widgets/footerButtons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerFooter extends StatefulWidget {
  const CustomerFooter({super.key, required this.activeTabIndex});
  final int activeTabIndex;
  @override
  State<CustomerFooter> createState() => _CustomerFooterState();
}

class _CustomerFooterState extends State<CustomerFooter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Footerbuttons(
              icon: const Icon(Icons.home),
              textButton: 'Home'.tr(),
              color: widget.activeTabIndex == 0
                  ? Colors.deepOrange
                  : Colors.grey,
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerHomeScreen(),
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Footerbuttons(
              icon: const Icon(Icons.shopping_cart),
              textButton: 'Cart'.tr(),
              color: widget.activeTabIndex == 1
                  ? Colors.deepOrange
                  : Colors.grey,
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerCartScreen(),
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Footerbuttons(
              icon: const Icon(Icons.receipt_long),
              textButton: 'Orders'.tr(),
              color: widget.activeTabIndex == 2
                  ? Colors.deepOrange
                  : Colors.grey,
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerOrdersScreen(),
                    ),
                  );
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Footerbuttons(
              icon: const Icon(Icons.person),
              textButton: 'Profile'.tr(),
              color: widget.activeTabIndex == 3
                  ? Colors.deepOrange
                  : Colors.grey,
              onTap: () {
                setState(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerProfileScreen(),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
