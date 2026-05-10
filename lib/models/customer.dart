class Customer {
  final int id;
  final String fullName;
  final String email;
  final String? phone;
  final String? role;
  final bool? blocked;
  final double? credits;

  Customer({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.role,
    this.blocked,
    this.credits,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? json['customerId'] ?? 0,
      fullName: json['fullName'] ?? json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      role: json['role'],
      blocked: json['blocked'],
      credits: json['credits'] != null ? (json['credits'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'blocked': blocked,
      'credits': credits,
    };
  }
}
