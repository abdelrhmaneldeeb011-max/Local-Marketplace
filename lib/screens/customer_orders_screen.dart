import 'package:Wafrnalak/app_bar.dart';
import 'package:Wafrnalak/customerFooter.dart';
import 'package:Wafrnalak/widgets/ordersButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Orders'.tr(),
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            Text(
              'Track your recent marketplace activities'.tr(),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrdersButton(text: 'All Orders'.tr()),
                OrdersButton(text: 'Active'.tr()),
                OrdersButton(text: 'Completed'.tr()),
                OrdersButton(text: 'Cancelled'.tr()),
              ],
            ),
            const SizedBox(height: 25),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'ORDER ID: 000000',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            color: Colors.deepOrange[100],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 1,
                              ),
                              child: Text(
                                'processing'.tr(),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'orderStatus'.tr(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'orderDate'.tr(),
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 14),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/img/MarketPhoto.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),

                        Text(
                          '1item'.tr(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '150 EGP'.tr(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return const Column(children: [CustomerFooter(activeTabIndex: 2)]);
          },
        ),
      ],
    );
  }
}
