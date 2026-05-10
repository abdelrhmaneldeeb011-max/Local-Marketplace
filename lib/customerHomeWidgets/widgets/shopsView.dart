import 'package:wafrnalak/customerHomeWidgets/widgets/shopsCard.dart';
import 'package:wafrnalak/models/product.dart';
import 'package:wafrnalak/services/api_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Shopsview extends StatefulWidget {
  final int? categoryId;
  const Shopsview({super.key, this.categoryId});

  @override
  State<Shopsview> createState() => _ShopsviewState();
}

class _ShopsviewState extends State<Shopsview> {
  List<Product> _products = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant Shopsview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _load();
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final prods = await ApiService.getProducts();
      final filtered = widget.categoryId == null
          ? prods
          : prods.where((p) => p.categoryId == widget.categoryId).toList();
      if (mounted) {
        setState(() {
          _products = filtered;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _addToCart(Product product) async {
    try {
      await ApiService.addToCart(product.id, 1);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Added ${product.name} to cart')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add to cart')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Local Shops Near You'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: _load,
                  child: Text(
                    'Refresh'.tr(),
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          if (_products.isEmpty)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text('No products found'.tr())),
            )
          else
            ..._products.map((p) => ShopsCard(
                  product: p,
                  onAddToCart: () => _addToCart(p),
                )),
        ],
      ),
    );
  }
}
