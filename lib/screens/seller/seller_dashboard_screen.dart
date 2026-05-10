import 'package:flutter/material.dart';
import 'package:wafrnalak/customerFooter.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 390).clamp(0.8, 1.15);

    return Scaffold(
      backgroundColor: Colors.white,

      /// FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        elevation: 6,
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wofrnhalk",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        "Welcome back, Atelier Studio",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.storefront_outlined,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              /// TITLE
              const Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              /// TOP CARDS
              Row(
                children: [
                  /// SALES
                  Expanded(
                    child: dashboardCard(
                      title: "TOTAL SALES",
                      value: "\$24,850",
                      subtitle: "+12.5% this month",
                      icon: Icons.attach_money,
                      color: Colors.deepOrange,
                    ),
                  ),

                  const SizedBox(width: 14),

                  /// INVENTORY
                  Expanded(
                    child: dashboardCard(
                      title: "INVENTORY",
                      value: "142",
                      subtitle: "Active Listings",
                      icon: Icons.inventory_2_outlined,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// NEW ORDERS CARD
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.deepOrange.shade700,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NEW ORDERS",
                            style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1.2,
                            ),
                          ),

                          Text(
                            "18",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Pending Fulfillment",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Add Product",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              /// RECENT PRODUCTS HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recent Products",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              /// PRODUCTS LIST
              Expanded(
                child: ListView(
                  children: const [
                    ProductCard(
                      title: "Minimalist Ceramic Timepiece",
                      price: "\$245.00",
                      category: "Home & Accessories",
                      status: "IN STOCK",
                      statusColor: Colors.green,
                    ),

                    SizedBox(height: 16),

                    ProductCard(
                      title: "Studio Series Headphones",
                      price: "\$1,200.00",
                      category: "Electronics",
                      status: "LOW STOCK",
                      statusColor: Colors.orange,
                    ),

                    SizedBox(height: 16),

                    ProductCard(
                      title: "Performance Trainer Red",
                      price: "\$185.00",
                      category: "Footwear",
                      status: "OUT OF STOCK",
                      statusColor: Colors.red,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(
              children: [CustomerFooter(activeTabIndex: 0, userType: 'seller')],
            );
          },
        ),
      ],
    );
  }

  /// DASHBOARD CARD
  Widget dashboardCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(height: 10),

          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              letterSpacing: 1.1,
            ),
          ),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 2),

          Text(subtitle, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String category;
  final String status;
  final Color statusColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.category,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          /// IMAGE BOX
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.deepOrange,
              size: 36,
            ),
          ),

          const SizedBox(width: 16),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  category,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),

                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
