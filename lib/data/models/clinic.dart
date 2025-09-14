import 'doctor.dart';

class Clinic {
  final String? id;
  final String name;
  final String photoUrl;
  final double? locationLongitude;
  final double? locationLatitude;
  final String address;
  final String? openTime;
  final String? closeTime;
  final String? createdAt;
  final String? updatedAt;
  final List<Doctor> doctors;

  Clinic({
    this.id,
    required this.name,
    required this.photoUrl,
    this.locationLongitude,
    this.locationLatitude,
    required this.address,
    this.openTime,
    this.closeTime,
    this.createdAt,
    this.updatedAt,
    this.doctors = const [],
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    String? formatTime(dynamic value) {
      if (value == null) return null;
      final str = value.toString();

      if (str.contains('T')) {
        try {
          final dt = DateTime.parse(str).toLocal();
          return "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
        } catch (_) {}
      }

      if (str.contains(':')) {
        final parts = str.split(':');
        if (parts.length >= 2) {
          return "${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}";
        }
      }

      if (str.contains('.')) {
        final parts = str.split('.');
        final hour = parts[0].padLeft(2, '0');
        final minute = (parts.length > 1 ? parts[1] : '00').padLeft(2, '0');
        return "$hour:$minute";
      }

      return str;
    }

    return Clinic(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      locationLongitude: (json['location_longitude'] as num?)?.toDouble(),
      locationLatitude: (json['location_latitude'] as num?)?.toDouble(),
      address: json['address'] ?? '',
      openTime: formatTime(json['open_time']),
      closeTime: formatTime(json['close_time']),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      doctors: (json['doctors'] != null && json['doctors'] is List)
          ? (json['doctors'] as List)
          .map((d) => Doctor.fromJson(d as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo_url': photoUrl,
      'location_longitude': locationLongitude,
      'location_latitude': locationLatitude,
      'address': address,
      'open_time': openTime,
      'close_time': closeTime,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'doctors': doctors.isNotEmpty
          ? doctors.map((d) => d.toJson()).toList()
          : [],
    };
  }
}
