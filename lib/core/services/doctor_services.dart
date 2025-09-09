import '../constants/url.dart';
import 'dio_client.dart';

class DoctorServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<void> getAllDoctors() async {
    try {
      final response = await dioClient.dio.get(Urls.getDoctors);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        print('Fetched ${data.length} doctors');
        data.forEach((doctor) => print(doctor['name']));
      } else {
        print('Failed to fetch doctors');
      }
    } catch (e) {
      print('Error fetching doctors: $e');
    }
  }

  Future<void> getSpecificDoctors() async {
    try {
      final response = await dioClient.dio.get(Urls.getDoctors);

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