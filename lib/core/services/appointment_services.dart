import 'package:flutter/cupertino.dart';
import '../../data/models/appointment.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class AppointmentService {
  final DioClient dioClient = DioClient();
  final Urls urls = Urls();

  Future<Appointment?> createAppointment({
    required String schedule_id,
    String? report_id,
  }) async {
    try {
      final body = {
        "schedule_id": schedule_id,
        if (report_id != null) "report_id": report_id,
      };

      final response = await dioClient.dio.post(
        Urls.createAppointment,
        data: body,
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
      print("Error in createAppointment: $e");
      rethrow;
    }
  }

  Future<List<Appointment>> getAppointment() async {
    try {
      final response = await dioClient.dio.get(Urls.getAppointment);

      if (response.statusCode == 200) {
        final decoded = response.data;

        print(decoded);

        if (decoded["status"] == "success") {
          final List<dynamic> data = decoded["data"];
          return data.map((item) => Appointment.fromJson(item)).toList();
        } else {
          throw Exception(decoded["message"] ?? "Failed to retrieve appointments");
        }
      } else {
        throw Exception("Error ${response.statusCode}: ${response.data}");
      }
    } catch (e) {
      print('Error in getAppointment: $e');
      rethrow;
    }
  }

  Future<Appointment?> getSpecificAppointment(String appointmentId) async {
    try {
      final response = await dioClient.dio.get(
        '${Urls.getAppointment}/$appointmentId',
      );

      if (response.statusCode == 200) {
        final decoded = response.data;

        if (decoded["status"] == "success") {
          final appointmentData = decoded["data"];

          if (appointmentData != null) {
            return Appointment.fromJson(appointmentData as Map<String, dynamic>);
          } else {
            debugPrint("Appointment data is null for id $appointmentId");
            return null;
          }
        } else {
          debugPrint("Failed to retrieve appointment: ${decoded["message"]}");
          return null;
        }
      } else {
        debugPrint("Error ${response.statusCode}: ${response.data}");
        return null;
      }
    } catch (e) {
      debugPrint('Error in getSpecificAppointment: $e');
      return null;
    }
  }

}