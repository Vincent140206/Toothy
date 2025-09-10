class User {
  final String? id;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? birthDate;
  final String? photoUrl;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  User({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.birthDate,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phone_number'],
      birthDate: json['birth_date'],
      photoUrl: json['photo_url'],
      role: json['role'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'birth_date': birthDate,
      'photo_url': photoUrl,
      'role': role,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
