import '../../data/models/schedule.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class ScheduleServices {
  final dioClient = DioClient();
  final urls = Urls();

  Future<List<Schedule>> getSchedules({String? doctorId}) async {
    try {
      final response = await dioClient.dio.get(
        Urls.getSchedules,
        queryParameters: {
          if (doctorId != null) "doctor_id": doctorId,
        },
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


  Future<Schedule> getSpecificSchedule({required String id}) async {
    final response = await dioClient.dio.get("${Urls.getSchedules}/$id");
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data['data'];
      return Schedule.fromJson(data);
    }
    throw Exception("Failed to load schedule");
  }

}
