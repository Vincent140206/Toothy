import '../../core/services/appointment_services.dart';
import '../../data/models/appointment.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/report.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();

  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<Appointment> get upcomingAppointments {
    final now = DateTime.now();
    return _appointments
        .where((appointment) =>
    appointment.status.toUpperCase() != "CANCELLED" &&
        appointment.date != null &&
        appointment.date!.isAfter(now))
        .toList()
      ..sort((a, b) => a.date!.compareTo(b.date!));
  }

  Appointment? get nearestAppointment {
    final upcoming = upcomingAppointments;
    return upcoming.isNotEmpty ? upcoming.first : null;
  }

  List<Appointment> get pastAppointments {
    final now = DateTime.now();
    return _appointments
        .where((appointment) =>
    appointment.date != null &&
        appointment.date!.isBefore(now))
        .toList()
      ..sort((a, b) => b.date!.compareTo(a.date!));
  }

  List<Appointment> get cancelledAppointments {
    return _appointments
        .where((appointment) =>
    appointment.status.toUpperCase() == "CANCELLED")
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  Future<void> fetchAppointments() async {
    try {
      _setLoading(true);
      _errorMessage = null;

      _appointments = await _appointmentService.getAppointment();

      print('Appointments loaded: ${_appointments.length}');
      print('Upcoming appointments: ${upcomingAppointments.length}');
      if (nearestAppointment != null) {
        print('Nearest appointment: ${nearestAppointment!.doctorName} - ${nearestAppointment!.dateFormatted}');
      }
      print("Raw appointments: $_appointments");
    } catch (e) {
      _errorMessage = e.toString();
      print('Error fetching appointments: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<Appointment?> createAppointment({
    required String schedule_id,
    String? additionalDescription, String? report_id,
  }) async {
    try {
      _setLoading(true);
      _errorMessage = null;

      final newAppointment = await _appointmentService.createAppointment(
        schedule_id: schedule_id,
        report_id: report_id
      );

      if (newAppointment != null) {
        await fetchAppointments();
        print('Appointment created successfully');
      }

      return newAppointment;
    } catch (e) {
      _errorMessage = e.toString();
      print('Error creating appointment: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<Appointment?> fetchAppointment(String appointmentId) async {
    return await _appointmentService.getSpecificAppointment(appointmentId);
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> refresh() async {
    await fetchAppointments();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
