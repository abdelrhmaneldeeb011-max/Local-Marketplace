import 'package:wafrnalak/screens/customer/customer_cart_screen.dart';
import 'package:wafrnalak/screens/customer/customer_home_screen.dart';
import 'package:wafrnalak/screens/customer/customer_orders_screen.dart';
import 'package:wafrnalak/screens/customer/customer_profile_screen.dart';
import 'package:wafrnalak/screens/seller/seller_dashboard_screen.dart';
import 'package:wafrnalak/screens/seller/seller_products_screen.dart';
import 'package:wafrnalak/screens/seller/seller_profile_screen.dart';

import 'widgets/footerButtons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerFooter extends StatefulWidget {
  const CustomerFooter({
    super.key,
    required this.activeTabIndex,
    required this.userType,
  });

  final int activeTabIndex;
  final String userType; // customer or seller

  @override
  State<CustomerFooter> createState() => _CustomerFooterState();
}

class _CustomerFooterState extends State<CustomerFooter> {
  @override
  Widget build(BuildContext context) {
    final isCustomer = widget.userType == 'customer';

    return Row(
      children: isCustomer ? _buildCustomerTabs() : _buildSellerTabs(),
    );
  }

  // ================= CUSTOMER =================
  List<Widget> _buildCustomerTabs() {
    return [
      _item(
        index: 0,
        icon: Icons.home,
        text: 'Home',
        screen: const CustomerHomeScreen(),
      ),
      _item(
        index: 1,
        icon: Icons.shopping_cart,
        text: 'Cart',
        screen: const CustomerCartScreen(),
      ),
      _item(
        index: 2,
        icon: Icons.receipt_long,
        text: 'Orders',
        screen: const CustomerOrdersScreen(),
      ),
      _item(
        index: 3,
        icon: Icons.person,
        text: 'Profile',
        screen: const CustomerProfileScreen(),
      ),
    ];
  }

  // ================= SELLER =================
  List<Widget> _buildSellerTabs() {
    return [
      _item(
        index: 0,
        icon: Icons.dashboard,
        text: 'Dashboard',
        screen: const SellerDashboardScreen(),
      ),
      _item(
        index: 1,
        icon: Icons.inventory_2,
        text: 'Products',
        screen: const SellerProductsScreen(),
      ),
      _item(
        index: 2,
        icon: Icons.person,
        text: 'Profile',
        screen: const SellerProfileScreen(),
      ),
    ];
  }

  // CUSTOMER ITEM (with navigation)
  Widget _item({
    required int index,
    required IconData icon,
    required String text,
    required Widget screen,
  }) {
    return Expanded(
      child: Center(
        child: Footerbuttons(
          icon: Icon(icon),
          textButton: text.tr(),
          color: widget.activeTabIndex == index
              ? Colors.deepOrange
              : Colors.grey,
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => screen),
            );
          },
        ),
      ),
    );
  }
}
