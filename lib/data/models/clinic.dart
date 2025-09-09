class Clinic {
  final int id;
  final String name;
  final String photo_url;
  final double location_longitude;
  final double location_latitude;
  final String address;
  final DateTime open_time;
  final DateTime close_time;
  final DateTime created_at;
  final DateTime updated_at;

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
      open_time: DateTime.parse(json['open_time']),
      close_time: DateTime.parse(json['close_time']),
      created_at: DateTime.parse(json['created_at']),
      updated_at: DateTime.parse(json['updated_at']),
    );
  }
}