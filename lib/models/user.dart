class User {
  final int id;
  final String name;
  final String email;
  final bool blocked;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.blocked = false,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['customerId'] ?? 0,
      name: json['name'] ?? json['fullName'] ?? '',
      email: json['email'] ?? '',
      blocked: json['blocked'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'blocked': blocked,
    };
  }
}
