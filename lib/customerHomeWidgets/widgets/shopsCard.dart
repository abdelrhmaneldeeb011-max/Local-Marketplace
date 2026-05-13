import 'package:flutter/material.dart';
import 'package:wafrnalak/services/api_service.dart';
import '../../models/product.dart';

class ShopsCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onAddToCart;

  const ShopsCard({super.key, required this.product, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {},
          child: Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                product.imageUrl != null && product.imageUrl!.isNotEmpty
                    ? Image.network(
                        '${ApiService.baseUrl}${product.imageUrl}',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/img/MarketPhoto.png',
                          height: 140,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/img/MarketPhoto.png',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '${product.price.toStringAsFixed(0)} EGP',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.categoryName ?? product.description ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_shopping_cart, color: Colors.deepOrange, size: 20),
                        onPressed: onAddToCart,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
