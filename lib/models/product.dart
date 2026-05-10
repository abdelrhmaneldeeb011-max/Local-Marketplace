class Product {
  final int id;
  final String name;
  final String? description;
  final double price;
  final int? categoryId;
  final String? categoryName;
  final String? imageUrl;
  final int? storeId;
  final bool? available;

  Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.categoryId,
    this.categoryName,
    this.imageUrl,
    this.storeId,
    this.available,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? json['productId'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'] ?? json['image'],
      storeId: json['storeId'],
      available: json['available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'storeId': storeId,
      'available': available,
    };
  }
}
