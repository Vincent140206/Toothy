class Clinic {
  final String id;
  final String name;
  final String photo_url;
  final double location_longitude;
  final double location_latitude;
  final String address;
  final String open_time;
  final String close_time;
  final String created_at;
  final String updated_at;

  Clinic({
    required this.id,
    required this.name,
    required this.photo_url,
    required this.location_longitude,
    required this.location_latitude,
    required this.address,
    required this.open_time,
    required this.close_time,
    required this.created_at,
    required this.updated_at,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      id: json['id'],
      name: json['name'],
      photo_url: json['photo_url'],
      location_longitude: (json['location_longitude'] as num).toDouble(),
      location_latitude: (json['location_latitude'] as num).toDouble(),
      address: json['address'],
      open_time: json['open_time'],
      close_time: json['close_time'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}