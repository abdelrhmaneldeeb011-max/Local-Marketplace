import 'package:Wafrnalak/app_bar.dart';
import 'package:flutter/material.dart';

class CustomerCheckoutScreen extends StatelessWidget {
  const CustomerCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar( title: 'checkout',),
      body: const Column(children: []),
      
    );
  }
}
