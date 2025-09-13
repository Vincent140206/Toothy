import 'package:dio/dio.dart';
import '../../data/models/schedule.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class ScheduleServices {
  final dioClient = DioClient();
  final urls = Urls();

  Future<List<Schedule>> getSchedules() async {
    try {
      final response = await dioClient.dio.get(
        "${Urls.baseUrl}/api/schedules?page=1&limit=10",
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => Schedule.fromJson(json)).toList();
      } else {
        throw Exception("Failed to fetch schedules");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

}
