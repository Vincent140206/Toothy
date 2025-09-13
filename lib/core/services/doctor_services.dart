import 'dart:convert';

import '../../data/models/clinic.dart';
import '../../data/models/doctor.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class DoctorServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<List<Doctor>> getAllDoctors() async {
    try {
      final response = await dioClient.dio.get(Urls.getDoctors);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctors');
    }
  }

  Future<Clinic?> getSpecificDoctors(String id) async {
    try {
      final response = await dioClient.dio.get('Urls.getDoctors$id');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        print('Fetched ${data.length} doctors');
      } else {
        print('Failed to fetch doctors');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    }
  }
}