import 'doctor.dart';

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
  final List<Doctor> doctors;

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
    required this.doctors
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    String formatTime(dynamic value) {
      if (value == null) return '';
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
      id: json['id'].toString(),
      name: json['name'] ?? '',
      photo_url: json['photo_url'] ?? '',
      location_longitude: (json['location_longitude'] as num).toDouble(),
      location_latitude: (json['location_latitude'] as num).toDouble(),
      address: json['address'] ?? '',
      open_time: formatTime(json['open_time']),
      close_time: formatTime(json['close_time']),
      created_at: json['created_at']?.toString() ?? '',
      updated_at: json['updated_at']?.toString() ?? '',
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
      'photo_url': photo_url,
      'location_longitude': location_longitude,
      'location_latitude': location_latitude,
      'address': address,
      'open_time': open_time,
      'close_time': close_time,
      'created_at': created_at,
      'updated_at': updated_at,
      'doctors': doctors.isNotEmpty
          ? doctors.map((d) => d.toJson()).toList()
          : [],
    };
  }
}
