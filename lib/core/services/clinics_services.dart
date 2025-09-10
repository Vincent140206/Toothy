
import '../../data/models/clinic.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class ClinicsServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<List<Clinic>> getClinics() async {
    try {
      final response = await dioClient.dio.get(Urls.getClinics);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final clinics = data.map((json) => Clinic.fromJson(json)).toList();

        print('Fetched ${clinics.length} clinics');
        clinics.forEach((c) => print(c.name));
        return data.map((json) => Clinic.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (e) {
      throw Exception('Failed to fetch doctors');
    }
  }

  Future<void> getSpecificClinic(String id) async {
    try {
      final response = await dioClient.dio.get('${Urls.getClinics}/$id');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final clinic = Clinic.fromJson(data);

        print('Fetched clinic: ${clinic.name}');
      } else if (response.statusCode == 404) {
        final message = response.data['message'] ?? 'Clinic not found';
        print(message);
      } else {
        print('Failed to fetch clinic');
      }
    } catch (e) {
      print('Error fetching clinic: $e');
    }
  }
}