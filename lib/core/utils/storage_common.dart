import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothy/data/models/clinic.dart';

class StorageCommon {
  static Future<void> saveClinics(List<Clinic> clinics) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(
      'clinics',
      jsonEncode(clinics.map((e) => e.toJson()).toList()),
    );
  }

  static Future<List<Clinic>> getClinics() async {
    final prefs = await SharedPreferences.getInstance();
    final clinicJson = prefs.getString('clinics');
    if (clinicJson == null) return [];
    final decoded = jsonDecode(clinicJson) as List;
    return decoded.map((e) => Clinic.fromJson(e)).toList();
  }

  static Future<void> clearClinics() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('clinic');
  }
}