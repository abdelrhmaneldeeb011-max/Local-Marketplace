class CartItem {
  final int productId;
  final String productName;
  final String? categoryName;
  final double price;
  final int quantity;
  final String? imageUrl;

  CartItem({
    required this.productId,
    required this.productName,
    this.categoryName,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'] ?? json['id'] ?? 0,
      productName: json['productName'] ?? json['name'] ?? '',
      categoryName: json['categoryName'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
      imageUrl: json['imageUrl'] ?? json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'categoryName': categoryName,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  double get total => price * quantity;
}

class Cart {
  final List<CartItem> items;
  final double total;

  Cart({
    required this.items,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>?)
            ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return Cart(
      items: items,
      total: (json['total'] as num?)?.toDouble() ??
          items.fold(0.0, (sum, i) => sum + i.total),
    );
  }

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}
