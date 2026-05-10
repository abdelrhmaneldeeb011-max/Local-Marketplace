// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import '../customerHomeWidgets/widgets/categoryList.dart';
import '../customerFooter.dart';
import '../customerHomeWidgets/widgets/searchBar.dart';
import '../customerHomeWidgets/widgets/shopsView.dart';
import '../services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int? _selectedCategoryId;

  Future<void> _onSearch(String query) async {
    if (query.isEmpty) return;
    try {
      final results = await ApiService.searchProducts(query);
      if (mounted) {
        // Optionally navigate to a search results page or refresh the list
        // For now, show a snackbar with count
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Found ${results.length} results')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Search failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Column(
        children: [
          SizedBox(height: 10),
          MySearchBar(onSearch: _onSearch),
          Categorylist(
            onCategorySelected: (id) {
              setState(() => _selectedCategoryId = id);
            },
          ),
          SizedBox(height: 5),
          Shopsview(categoryId: _selectedCategoryId),
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
