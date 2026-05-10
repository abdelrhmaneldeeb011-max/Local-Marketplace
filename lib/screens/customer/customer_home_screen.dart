import 'package:flutter/material.dart';
import '../../app_bar.dart';
import '../../customerHomeWidgets/widgets/categoryList.dart';
import '../../customerHomeWidgets/widgets/searchBar.dart';
import '../../customerHomeWidgets/widgets/shopsView.dart';
import '../../customerFooter.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const MySearchBar(),
          Categorylist(
            onCategorySelected: (id) {
              setState(() => _selectedCategoryId = id);
            },
          ),
          const SizedBox(height: 5),
          Shopsview(categoryId: _selectedCategoryId),
        ],
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(children: [CustomerFooter(activeTabIndex: 0, userType: 'customer')]);
          },
        ),
      ],
    );
  }
}
