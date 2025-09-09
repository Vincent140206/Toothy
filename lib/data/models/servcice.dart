class Service {
  final name;
  final description;
  final price;
  final created_at;
  final updated_at;
  final id;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.created_at,
    required this.updated_at,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}