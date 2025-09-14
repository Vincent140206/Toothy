import 'clinic.dart';
import 'doctor.dart';

class Schedule {
  final String id;
  final String doctorId;
  final String clinicId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final Doctor? doctor;
  final Clinic? clinic;
  final String? clinicName;

  Schedule({
    required this.id,
    required this.doctorId,
    required this.clinicId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.doctor,
    this.clinic,
    this.clinicName
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      clinicId: json['clinic_id'] ?? '',
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : DateTime.now(),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'])
          : DateTime.now(),
      date: json['date'] != null
          ? DateTime.parse(json['date'])
          : DateTime.now(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      status: json['status'] ?? 'inactive',
      doctor: json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null,
      clinic: json['clinic'] != null ? Clinic.fromJson(json['clinic']) : null,
      clinicName: json['clinic']?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "doctor_id": doctorId,
      "clinic_id": clinicId,
      "start_time": startTime.toIso8601String(),
      "end_time": endTime.toIso8601String(),
      "date": date.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "status": status,
      "doctor": doctor?.toJson(),
      "clinic": clinic?.toJson(),
    };
  }
}