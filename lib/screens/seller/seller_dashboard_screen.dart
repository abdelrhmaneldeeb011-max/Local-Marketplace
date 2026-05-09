import 'package:flutter/material.dart';

class SellerDashboardScreen extends StatelessWidget {
  const SellerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 390).clamp(0.8, 1.15);
    double s(double v) => v * scale;

    return Scaffold(
      backgroundColor: Colors.white,

      /// FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        elevation: 6,
        onPressed: () {},
        child: Icon(Icons.add, color: Colors.white, size: s(20)),
      ),

      /// BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_customize),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(s(18)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Wofrnhalk",
                        style: TextStyle(
                          fontSize: s(28),
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),

                      SizedBox(height: s(6)),

                      Text(
                        "Welcome back, Atelier Studio",
                        style: TextStyle(color: Colors.grey, fontSize: s(14)),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.all(s(12)),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.storefront_outlined,
                      color: Colors.deepOrange,
                      size: s(22),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(20)),

              /// TITLE
              Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: s(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: s(16)),

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

                  SizedBox(width: s(12)),

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

              SizedBox(height: s(14)),

              /// NEW ORDERS CARD
              Container(
                padding: EdgeInsets.all(s(16)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepOrange.shade400,
                      Colors.deepOrange.shade700,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(s(12)),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: s(28),
                      ),
                    ),

                    SizedBox(width: s(12)),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NEW ORDERS",
                            style: TextStyle(
                              color: Colors.white70,
                              letterSpacing: 1.2,
                              fontSize: s(12),
                            ),
                          ),

                          SizedBox(height: s(6)),

                          Text(
                            "18",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: s(34),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: s(6)),

                          Text(
                            "Pending Fulfillment",
                            style: TextStyle(color: Colors.white70, fontSize: s(12)),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepOrange,
                        padding: EdgeInsets.symmetric(
                          horizontal: s(14),
                          vertical: s(10),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Add Product",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: s(12)),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: s(20)),

              /// RECENT PRODUCTS HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recent Products",
                    style: TextStyle(
                      fontSize: s(18),
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: s(14),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: s(14)),

              /// PRODUCTS LIST
              Expanded(
                child: ListView(
                  children: [
                    ProductCard(
                      title: "Minimalist Ceramic Timepiece",
                      price: "\$245.00",
                      category: "Home & Accessories",
                      status: "IN STOCK",
                      statusColor: Colors.green,
                    ),

                    SizedBox(height: s(12)),

                    ProductCard(
                      title: "Studio Series Headphones",
                      price: "\$1,200.00",
                      category: "Electronics",
                      status: "LOW STOCK",
                      statusColor: Colors.orange,
                    ),

                    SizedBox(height: s(12)),

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
      padding: EdgeInsets.all(s(14)),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(s(10)),
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: s(20)),
          ),

          SizedBox(height: s(12)),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: s(11),
              letterSpacing: 1.1,
            ),
          ),

          SizedBox(height: s(8)),

          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: s(20),
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: s(6)),

          Text(subtitle, style: TextStyle(color: color, fontSize: s(11))),
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
    final width = MediaQuery.of(context).size.width;
    final scale = (width / 390).clamp(0.8, 1.15);
    double s(double v) => v * scale;

    return Container(
      padding: EdgeInsets.all(s(12)),

      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Row(
        children: [
          /// IMAGE BOX
          Container(
            height: s(64),
            width: s(64),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.deepOrange,
              size: s(28),
            ),
          ),

          SizedBox(width: s(12)),

          /// TEXTS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: s(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: s(8)),

                Text(
                  category,
                  style: TextStyle(color: Colors.grey, fontSize: s(12)),
                ),

                SizedBox(height: s(10)),

                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: s(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: s(10),
                        vertical: s(6),
                      ),

                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: s(11),
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
