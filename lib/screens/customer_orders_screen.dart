import 'package:wafrnalak/app_bar.dart';
import 'package:wafrnalak/customerFooter.dart';
import 'package:wafrnalak/models/order.dart';
import 'package:wafrnalak/services/api_service.dart';
import 'package:wafrnalak/widgets/ordersButton.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomerOrdersScreen extends StatefulWidget {
  const CustomerOrdersScreen({super.key});

  @override
  State<CustomerOrdersScreen> createState() => _CustomerOrdersScreenState();
}

class _CustomerOrdersScreenState extends State<CustomerOrdersScreen> {
  List<Order> _orders = [];
  bool _loading = true;
  String? _statusFilter;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final orders = await ApiService.getMyOrders(status: _statusFilter);
      if (mounted) setState(() => _orders = orders);
    } catch (e) {
      // ignore
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _filter(String? status) {
    setState(() => _statusFilter = status);
    _load();
  }

  Future<void> _cancelOrder(int orderId) async {
    try {
      await ApiService.cancelOrder(orderId);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cancel failed')),
        );
      }
    }
  }

  Widget _buildOrderCard(Order order) {
    final dateStr = order.createdAt != null
        ? DateFormat('MMM dd, yyyy').format(order.createdAt!)
        : '';
    final itemCount = order.items.fold(0, (sum, i) => sum + i.quantity);
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'ORDER ID: ${order.id.toString().padLeft(6, '0')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Colors.deepOrange[100],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 1,
                          ),
                          child: Text(
                            order.status.tr(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  order.status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dateStr,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
                SizedBox(height: 14),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/img/MarketPhoto.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        '$itemCount items',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${order.total.toStringAsFixed(0)} EGP',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                if (order.status.toLowerCase() == 'processing')
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _cancelOrder(order.id),
                      child: Text('Cancel', style: TextStyle(color: Colors.red)),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: ListView(
          children: [
            Text(
              'Your Orders'.tr(),
              style: TextStyle(fontSize: 22, color: Colors.black),
            ),
            Text(
              'Track your recent marketplace activities'.tr(),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 25),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OrdersButton(
                    text: 'All Orders'.tr(),
                    selected: _statusFilter == null,
                    onTap: () => _filter(null),
                  ),
                  const SizedBox(width: 8),
                  OrdersButton(
                    text: 'Active'.tr(),
                    selected: _statusFilter == 'processing',
                    onTap: () => _filter('processing'),
                  ),
                  const SizedBox(width: 8),
                  OrdersButton(
                    text: 'Completed'.tr(),
                    selected: _statusFilter == 'completed',
                    onTap: () => _filter('completed'),
                  ),
                  const SizedBox(width: 8),
                  OrdersButton(
                    text: 'Cancelled'.tr(),
                    selected: _statusFilter == 'cancelled',
                    onTap: () => _filter('cancelled'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            if (_loading)
              Center(child: CircularProgressIndicator())
            else if (_orders.isEmpty)
              Center(child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('No orders found'.tr()),
              ))
            else
              ..._orders.map(_buildOrderCard),
          ],
        ),
      ),
      persistentFooterButtons: [
        Builder(
          builder: (context) {
            return const Column(children: [CustomerFooter(activeTabIndex: 2)]);
          },
        ),
      ],
    );
  }
}
