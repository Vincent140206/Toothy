class Schedule {
  final String id;
  final String doctorId;
  final String clinicId;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime date;
  final String doctorName;
  final String clinicName;

  Schedule({
    required this.id,
    required this.doctorId,
    required this.clinicId,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.doctorName,
    required this.clinicName,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      doctorId: json['doctor_id'],
      clinicId: json['clinic_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      date: DateTime.parse(json['date']),
      doctorName: json['doctor']?['name'] ?? '',
      clinicName: json['clinic']?['name'] ?? '',
    );
  }
}
