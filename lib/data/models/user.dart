class User {
  final full_name;
  final email;
  final password;
  final phone_number;
  final birth_date;
  final photo_url;
  final role;
  final created_at;
  final updated_at;
  final id;

  User({
    required this.id,
    required this.full_name,
    required this.email,
    required this.password,
    required this.phone_number,
    required this.birth_date,
    required this.photo_url,
    required this.role,
    required this.created_at,
    required this.updated_at,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      full_name: json['full_name'],
      email: json['email'],
      password: json['password'],
      phone_number: json['phone_number'],
      birth_date: json['birth_date'],
      photo_url: json['photo_url'],
      role: json['role'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}