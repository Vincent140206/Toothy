class Doctor {
  final profile_photo_url;
  final name;
  final years_experience;
  final created_at;
  final updated_at;
  final id;

  Doctor({
    required this.id,
    required this.profile_photo_url,
    required this.name,
    required this.years_experience,
    required this.created_at,
    required this.updated_at,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      profile_photo_url: json['profile_photo_url'],
      name: json['name'],
      years_experience: json['years_experience'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}