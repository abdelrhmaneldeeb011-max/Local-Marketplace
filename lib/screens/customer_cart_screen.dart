import 'package:wafrnalak/app_bar.dart';
import 'package:wafrnalak/customerFooter.dart';
import 'package:wafrnalak/models/cart.dart' as models;
import 'package:wafrnalak/screens/customer_checkout_confirmed_screen.dart';
import 'package:wafrnalak/services/api_service.dart';
import 'package:wafrnalak/widgets/cartItem.dart';
import 'package:wafrnalak/widgets/checkoutView.dart';
import 'package:flutter/material.dart';

class CustomerCartScreen extends StatefulWidget {
  const CustomerCartScreen({super.key});

  @override
  State<CustomerCartScreen> createState() => _CustomerCartScreenState();
}

class _CustomerCartScreenState extends State<CustomerCartScreen> {
  models.Cart _cart = models.Cart(items: [], total: 0);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    setState(() => _loading = true);
    try {
      final cart = await ApiService.getCart();
      if (mounted) setState(() => _cart = cart);
    } catch (e) {
      // ignore
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _removeItem(int productId) async {
    try {
      final cart = await ApiService.removeFromCart(productId);
      if (mounted) setState(() => _cart = cart);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to remove item')),
        );
      }
    }
  }

  Future<void> _checkout() async {
    try {
      final order = await ApiService.checkout();
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const OrderConfirmedPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Checkout failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemCount = _cart.itemCount;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items in your Cart',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
            SizedBox(height: 8),
            Text(
              '$itemCount Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: _loading
                  ? Center(child: CircularProgressIndicator())
                  : _cart.items.isEmpty
                      ? Center(child: Text('Your cart is empty'))
                      : ListView(
                          children: _cart.items.map((item) => CartItemWidget(
                            item: item,
                            onQuantityChanged: _loadCart,
                            onRemove: () => _removeItem(item.productId),
                          )).toList(),
                        ),
            ),
            CheckoutView(
              total: _cart.total,
              itemCount: itemCount,
              onCheckout: _cart.items.isNotEmpty ? _checkout : null,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return Column(children: [CustomerFooter(activeTabIndex: 1)]);
          },
        ),
      ],
    );
  }
}
