class OrderItem {
  final int productId;
  final String productName;
  final double price;
  final int quantity;
  final String? imageUrl;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] ?? json['id'] ?? 0,
      productName: json['productName'] ?? json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      quantity: json['quantity'] ?? 1,
      imageUrl: json['imageUrl'] ?? json['image'],
    );
  }
}

class Order {
  final int id;
  final String status;
  final DateTime? createdAt;
  final double total;
  final List<OrderItem> items;
  final String? shippingStatus;
  final String? paymentStatus;

  Order({
    required this.id,
    required this.status,
    this.createdAt,
    required this.total,
    required this.items,
    this.shippingStatus,
    this.paymentStatus,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? json['orderId'] ?? 0,
      status: json['status'] ?? 'processing',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      shippingStatus: json['shippingStatus'],
      paymentStatus: json['paymentStatus'],
    );
  }
}
