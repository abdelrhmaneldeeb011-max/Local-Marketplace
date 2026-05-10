import 'package:flutter/material.dart';
import 'package:wafrnalak/customerFooter.dart';

class SellerProductsScreen extends StatefulWidget {
  const SellerProductsScreen({super.key});

  @override
  State<SellerProductsScreen> createState() => _SellerProductsScreenState();
}

class _SellerProductsScreenState extends State<SellerProductsScreen> {
  int activeTab = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("My Products", style: TextStyle(color: Colors.black)),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Quick inventory lookup...",
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Filters
            Row(
              children: [
                _filterChip("All"),
                _filterChip("In Stock"),
                _filterChip("Out of Stock"),
              ],
            ),

            const SizedBox(height: 16),

            // Products List
            Expanded(
              child: ListView(
                children: const [
                  _ProductCard(
                    name: "Horizon Chronograph",
                    price: 249,
                    inStock: true,
                  ),
                  _ProductCard(
                    name: "Terra Cotta Vessel",
                    price: 85,
                    inStock: false,
                  ),
                  _ProductCard(
                    name: "Instant Echo IV",
                    price: 120,
                    inStock: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(
              children: [CustomerFooter(activeTabIndex: 1, userType: 'seller')],
            );
          },
        ),
      ],
    );
  }

  Widget _filterChip(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(label: Text(title), backgroundColor: Colors.grey.shade200),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final double price;
  final bool inStock;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.inStock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text("\$$price"),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: inStock ? Colors.deepOrange : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  inStock ? "IN STOCK" : "OUT OF STOCK",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: Colors.deepOrange,
            child: const Icon(Icons.shopping_bag, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
