import 'package:flutter/material.dart';
import 'package:wafrnalak/customerFooter.dart';

class SellerProfileScreen extends StatelessWidget {
  const SellerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color deepOrange = Colors.deepOrange;
    const Color lightGrey = Color(0xFFF4F4F4);
    const Color darkGrey = Color(0xFF757575);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: deepOrange.withOpacity(.15),
                    child: const Icon(
                      Icons.storefront,
                      color: deepOrange,
                      size: 38,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Wofrnhalk",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: deepOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "PRO SELLER",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// RATING
              Row(
                children: const [
                  Icon(Icons.star, color: Colors.amber, size: 22),
                  SizedBox(width: 6),
                  Text(
                    "4.9 RATING",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// DESCRIPTION
              const Text(
                "Crafting bespoke leather goods and timeless accessories since 2018.\n"
                "Based in the heart of the design district.",
                style: TextStyle(color: darkGrey, fontSize: 15, height: 1.6),
              ),

              const SizedBox(height: 30),

              /// ACCOUNT INFO CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Account Information",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    buildInfoTile(
                      title: "STORE NAME",
                      value: "Wofrnhalk Studio",
                      icon: Icons.store_mall_directory_outlined,
                    ),

                    const SizedBox(height: 18),

                    buildInfoTile(
                      title: "EMAIL ADDRESS",
                      value: "julian@kinetic-atelier.design",
                      icon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 18),

                    buildInfoTile(
                      title: "PHONE NUMBER",
                      value: "+1 (555) 012-3456",
                      icon: Icons.phone_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// PREFERENCES
              const Text(
                "Preferences",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: lightGrey,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: true,
                      activeColor: deepOrange,
                      contentPadding: EdgeInsets.zero,
                      title: const Text(
                        "Order Notifications",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      onChanged: (v) {},
                    ),

                    const Divider(),

                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.language, color: deepOrange),
                      title: const Text(
                        "Shop Language",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      trailing: const Text(
                        "ENGLISH",
                        style: TextStyle(
                          color: deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// BUTTONS
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: deepOrange),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: deepOrange,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// FOOTER
              Center(
                child: Column(
                  children: const [
                    Text(
                      "MEMBER SINCE NOVEMBER 2018",
                      style: TextStyle(
                        color: darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "ID: ATELIER-992-JV",
                      style: TextStyle(color: Colors.grey),
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
              children: [CustomerFooter(activeTabIndex: 2, userType: 'seller')],
            );
          },
        ),
      ],
    );
  }

  Widget buildInfoTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: Colors.deepOrange),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
