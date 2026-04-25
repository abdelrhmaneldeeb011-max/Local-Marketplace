import 'package:Wafrnalak/app_bar.dart';
import 'package:flutter/material.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white, appBar: MyAppBar());
  }
}
