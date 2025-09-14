
import 'package:toothy/data/models/clinic.dart';
import 'package:toothy/data/models/schedule.dart';
import 'package:toothy/data/models/specialist.dart';

class Doctor {
  final String id;
  final String profilePhotoUrl;
  final String name;
  final int yearsExperience;
  final String createdAt;
  final String updatedAt;
  final List<Specialist> specialists;
  final Clinic? clinic;
  final String? scheduleId;
  final List<Schedule> schedules;

  Doctor({
    required this.id,
    required this.profilePhotoUrl,
    required this.name,
    required this.yearsExperience,
    required this.createdAt,
    required this.updatedAt,
    required this.specialists,
    required this.schedules,
    this.scheduleId,
    this.clinic,
  });

  factory Doctor.fromJson(Map<String, dynamic> json, {Clinic? clinicData}) {
    return Doctor(
      id: json['id']?.toString() ?? '',
      profilePhotoUrl: json['profile_photo_url']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      yearsExperience: _parseInt(json['years_experience']),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      clinic: clinicData,
      specialists: (json['specialists'] is List)
          ? (json['specialists'] as List)
          .map((s) => Specialist.fromJson(s as Map<String, dynamic>))
          .toList()
          : [],
      scheduleId: json['schedule_id']?.toString(),
      schedules: (json['schedules'] is List)
          ? (json['schedules'] as List)
          .map((s) => Schedule.fromJson(s as Map<String, dynamic>))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile_photo_url': profilePhotoUrl,
      'name': name,
      'years_experience': yearsExperience,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'specialists': specialists.map((s) => s.toJson()).toList(),
      'clinic': clinic?.toJson(),
      'schedules': schedules.map((s) => s.toJson()).toList(),
      'schedule_id': scheduleId,
    };
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    return int.tryParse(value.toString()) ?? 0;
  }
}
