import 'package:Wafrnalak/app_bar.dart';
import 'package:Wafrnalak/customerFooter.dart';
import 'package:Wafrnalak/widgets/cartItem.dart';
import 'package:Wafrnalak/widgets/checkoutView.dart';
import 'package:flutter/material.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items in your Cart',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            SizedBox(height: 8),
            Text(
              '3 Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: ListView(children: [CartItem(), CartItem(), CartItem()]),
            ),
            CheckoutView(),
          ],
        ),
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(children: [CustomerFooter(activeTabIndex: 1)]);
          },
        ),
      ],
    );
  }
}
