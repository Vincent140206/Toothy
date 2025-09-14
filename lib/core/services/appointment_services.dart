import 'package:toothy/core/constants/url.dart';
import 'package:toothy/core/services/dio_client.dart';
import '../../data/models/appointment.dart';

class AppointmentService {
  final DioClient dioClient = DioClient();
  final Urls urls = Urls();

  Future<Appointment?> createAppointment({
    required String scheduleId,
    String? additionalDescription,
  }) async {
    try {
      final response = await dioClient.dio.post(
        Urls.createAppointment,
        data: {
          "schedule_id": scheduleId,
          "additional_description": additionalDescription,
        },
      );

      if (response.statusCode == 201) {
        final decoded = response.data;

        if (decoded["status"] == "success") {
          return Appointment.fromJson(decoded["data"]);
        } else {
          throw Exception(decoded["message"] ?? "Failed to create appointment");
        }
      } else {
        throw Exception("Error ${response.statusCode}: ${response.data}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Appointment>> getAppointment() async {
    try {
      final response = await dioClient.dio.get(Urls.getAppointment);

      if (response.statusCode == 200) {
        final decoded = response.data;

        if (decoded["status"] == "success") {
          final List<dynamic> data = decoded["data"];

          final cancelledAppointments = data
              .where((item) => item["status"] == "CANCELLED")
              .map((item) => Appointment.fromJson(item))
              .toList();

          return cancelledAppointments;
        } else {
          throw Exception(decoded["message"] ?? "Failed to retrieve appointments");
        }
      } else {
        throw Exception("Error ${response.statusCode}: ${response.data}");
      }
    } catch (e) {
      rethrow;
    }
  }
}