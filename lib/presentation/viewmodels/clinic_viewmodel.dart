import '../../core/services/clinics_services.dart';

class ClinicViewModel {
  final ClinicsServices _clinicsService = ClinicsServices();
  String? errorMessage;

  Future<bool> getClinics() async {
    try {
      await _clinicsService.getClinics();
      return true;
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }

  Future<bool> getSpecificClinics(String id) async {
    try {
      await _clinicsService.getSpecificClinic("1");
      return true;
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }
}