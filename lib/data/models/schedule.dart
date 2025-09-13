class Schedule {
  final String id;
  final String doctorId;
  final String clinicId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Clinic clinic;
  final Doctor doctor;

  Schedule({
    required this.id,
    required this.doctorId,
    required this.clinicId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.clinic,
    required this.doctor,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      doctorId: json['doctor_id'],
      clinicId: json['clinic_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      clinic: Clinic.fromJson(json['clinic']),
      doctor: Doctor.fromJson(json['doctor']),
    );
  }
}

class Clinic {
  final String name;
  final String address;
  final String photoUrl;
  final DateTime openTime;
  final DateTime closeTime;

  Clinic({
    required this.name,
    required this.address,
    required this.photoUrl,
    required this.openTime,
    required this.closeTime,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      name: json['name'],
      address: json['address'],
      photoUrl: json['photo_url'],
      openTime: DateTime.parse(json['open_time']),
      closeTime: DateTime.parse(json['close_time']),
    );
  }
}

class Doctor {
  final String id;
  final String name;
  final String profilePhotoUrl;
  final int yearsExperience;
  final List<Specialist> specialists;

  Doctor({
    required this.id,
    required this.name,
    required this.profilePhotoUrl,
    required this.yearsExperience,
    required this.specialists,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      profilePhotoUrl: json['profile_photo_url'],
      yearsExperience: json['years_experience'],
      specialists: (json['specialists'] as List)
          .map((s) => Specialist.fromJson(s))
          .toList(),
    );
  }
}

class Specialist {
  final String title;

  Specialist({required this.title});

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(title: json['title']);
  }
}
