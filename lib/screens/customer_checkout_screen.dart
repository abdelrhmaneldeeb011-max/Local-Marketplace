import 'package:Wafrnalak/screens/Customer_checkout_confirmed_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomerCheckoutScreen extends StatefulWidget {
  const CustomerCheckoutScreen({super.key});

  @override
  State<CustomerCheckoutScreen> createState() => _CustomerCheckoutScreenState();
}

class _CustomerCheckoutScreenState extends State<CustomerCheckoutScreen> {
  int selectedPayment = 0; // 0 = VISA, 1 = Vodafone Cash

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "checkout".tr(),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// Delivery Address
          buildSectionTitle("delivery_address".tr()),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xffF3F3F3),
                  child: Icon(Icons.location_on, color: Colors.black),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "home_office".tr(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Awlaad naser ,Elmanzla\nDakahlia",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: Text("change".tr())),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// Delivery Type
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                const Icon(Icons.flash_on, color: Colors.yellow),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "express_delivery".tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "arrives_tomorrow".tr(),
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// Payment Method
          buildSectionTitle("payment_method".tr()),
          const SizedBox(height: 12),

          buildPaymentCard(
            icon: Icons.credit_card,
            title: "VISA",
            subtitle: "•••• 4242\nExpires 12/26",
            value: 0,
          ),

          const SizedBox(height: 12),

          buildPaymentCard(
            icon: Icons.phone_iphone,
            title: "Vodafone Cash",
            subtitle: "",
            value: 1,
          ),

          const SizedBox(height: 25),

          /// Promo Code
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "promo_code".tr(),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                onPressed: () {},
                child: Text(
                  "apply".tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          /// Order Summary
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                buildPriceRow("subtotal_items".tr(), "\$128.00"),
                buildPriceRow("shipping".tr(), "FREE"),
                buildPriceRow("tax".tr(), "\$10.24"),
                const Divider(),
                buildPriceRow("total".tr(), "\$138.24", isBold: true),
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// Confirm Button
          SizedBox(
            height: 58,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrderConfirmedPage(),
                  ),
                );
              },
              child: Text(
                "confirm_purchase".tr(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget buildPaymentCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required int value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xffF3F3F3),
            child: Icon(icon),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (subtitle.isNotEmpty)
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),

          Radio<int>(
            value: value,
            groupValue: selectedPayment,
            activeColor: Colors.deepOrange,
            onChanged: (val) {
              setState(() {
                selectedPayment = val!;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget buildPriceRow(String title, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 15,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 15,
          ),
        ),
      ],
    );
  }
}
