import 'package:flutter/material.dart';
import '../models/cart.dart' as models;
import '../services/api_service.dart';

class CartItemWidget extends StatelessWidget {
  final models.CartItem item;
  final VoidCallback? onQuantityChanged;
  final VoidCallback? onRemove;

  const CartItemWidget({
    super.key,
    required this.item,
    this.onQuantityChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                  ? Image.network(
                      '${ApiService.baseUrl}${item.imageUrl}',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/img/MarketPhoto.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/img/MarketPhoto.png',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    item.categoryName ?? '',
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        '${item.price.toStringAsFixed(0)} EGP',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.deepOrange,
                        ),
                      ),
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 30,
                          color: Colors.grey[200],
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 15),
                                color: Colors.deepOrange,
                                onPressed: () async {
                                  if (item.quantity > 1) {
                                    await ApiService.addToCart(item.productId, item.quantity - 1);
                                    onQuantityChanged?.call();
                                  }
                                },
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add, size: 15),
                                color: Colors.deepOrange,
                                onPressed: () async {
                                  await ApiService.addToCart(item.productId, item.quantity + 1);
                                  onQuantityChanged?.call();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
