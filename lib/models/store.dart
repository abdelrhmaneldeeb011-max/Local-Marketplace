class Store {
  final int id;
  final String name;
  final String? owner;
  final bool active;

  Store({
    required this.id,
    required this.name,
    this.owner,
    this.active = true,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] ?? json['storeId'] ?? 0,
      name: json['name'] ?? '',
      owner: json['owner'] ?? json['ownerName'],
      active: json['active'] ?? json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'active': active,
    };
  }
}
