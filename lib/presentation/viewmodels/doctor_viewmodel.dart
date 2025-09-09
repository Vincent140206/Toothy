import 'package:toothy/core/services/doctor_services.dart';

class DoctorViewModel {
  final DoctorServices doctorServices = DoctorServices();
  String? errorMessage;

  Future<bool> getAllDoctors() async {
    try {
      await doctorServices.getAllDoctors();
      return true;
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }

  Future<bool> getSpecificDoctors() async {
    try {
      await doctorServices.getSpecificDoctors();
      return true;
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }
}