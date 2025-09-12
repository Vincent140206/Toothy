class Urls {
  static const String baseUrl = 'https://toothy-api.bccdev.id';
  // Auth
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String checkSession = '$baseUrl/api/auth/session';
  // Clinics
  static const String getClinics = '$baseUrl/api/clinics';
  static const String getSpecificClinics = '$baseUrl/api/clinics/';
  // Doctors
  static const String getDoctors = '$baseUrl/api/doctors';
  static const String getSpecificDoctors = '$baseUrl/api/doctors/';
  // Articles
  static const String getArticles = '$baseUrl/api/articles';
  static const String getSpecificArticles = '$baseUrl/api/articles/';
}