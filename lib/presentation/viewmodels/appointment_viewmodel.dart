import 'package:flutter/material.dart';
import 'package:toothy/data/models/appointment.dart';
import '../../core/services/appointment_services.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentService _appointmentService = AppointmentService();

  bool _isLoading = false;
  String? _errorMessage;
  List<Appointment> _appointments = [];

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Appointment> get appointments => _appointments;

  Future<void> createAppointment({
    required String scheduleId,
    String? additionalDescription, String? userId,
  }) async {
    _setLoading(true);
    try {
      final appointment = await _appointmentService.createAppointment(
        scheduleId: scheduleId,
        additionalDescription: additionalDescription,
      );

      if (appointment != null) {
        _appointments.add(appointment);
        notifyListeners();
      }
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchCancelledAppointments() async {
    _setLoading(true);
    try {
      final data = await _appointmentService.getAppointment();
      _appointments = data;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
