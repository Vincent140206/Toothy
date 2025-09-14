import 'package:toothy/data/models/schedule.dart';
import 'package:toothy/data/models/transaction.dart';
import 'package:toothy/data/models/user.dart';
import 'package:intl/intl.dart';

class Appointment {
  final String id;
  final String userId;
  final String scheduleId;
  final String? reportId;
  final String? transactionId;
  final String? additionalDescription;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Transaction? transaction;
  final User? user;
  final Schedule? schedule;

  Appointment({
    required this.id,
    required this.userId,
    required this.scheduleId,
    this.reportId,
    this.transactionId,
    this.additionalDescription,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.transaction,
    this.user,
    this.schedule,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      userId: json['user_id'],
      scheduleId: json['schedule_id'],
      reportId: json['report_id'],
      transactionId: json['transaction_id'],
      additionalDescription: json['additional_description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      transaction: json['transaction'] != null
          ? Transaction.fromJson(json['transaction'])
          : null,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      schedule: json['schedule'] != null ? Schedule.fromJson(json['schedule']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "schedule_id": scheduleId,
      "report_id": reportId,
      "transaction_id": transactionId,
      "additional_description": additionalDescription,
      "status": status,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "transaction": transaction?.toJson(),
      "user": user?.toJson(),
      "schedule": schedule?.toJson(),
    };
  }
}

enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

AppointmentStatus parseStatus(String status) {
  switch (status.toUpperCase()) {
    case "PENDING":
      return AppointmentStatus.pending;
    case "CONFIRMED":
      return AppointmentStatus.confirmed;
    case "CANCELLED":
      return AppointmentStatus.cancelled;
    case "COMPLETED":
      return AppointmentStatus.completed;
    default:
      throw Exception("Unknown appointment status: $status");
  }
}

extension AppointmentExtension on Appointment {
  DateTime? get date {
    return schedule?.startTime;
  }

  String get doctorName {
    return schedule?.doctor?.name ?? "Unknown Doctor";
  }

  String get dateFormatted {
    final d = date;
    if (d == null) return "-";
    return DateFormat("dd MMM yyyy, HH:MM", "id_ID").format(d);
  }
}
