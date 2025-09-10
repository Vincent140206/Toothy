import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../data/models/user.dart';
import '../constants/url.dart';
import '../utils/user_storage.dart';
import 'dio_client.dart';

class AuthServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<bool> checkSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      print("DEBUG checkSession: token=$token");

      if (token != null) {
        final response = await dioClient.dio.get(
          Urls.checkSession,
          options: Options(headers: {"Authorization": "Bearer $token"}),
        );

        if (response.statusCode == 200) {
          final data = response.data['data'];
          final user = User.fromJson(data);
          await UserStorage.saveUser(user);
          return true;
        }
      }
      return false;
    } catch (e) {
      print("DEBUG checkSession error: $e");
      return false;
    }
  }


  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await dioClient.dio.post(
        Urls.login,
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['data']?['token']?.toString();

        if (token == null || token.isEmpty) {
          return {
            'success': false,
            'message': 'Token tidak ditemukan di response'
          };
        }

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return {'success': true, 'token': token};
      } else {
        return {'success': false, 'message': 'Login failed'};
      }
    } on DioError catch (e) {
      final data = e.response?.data;
      String message = data?['message'] ?? 'Login failed';
      return {'success': false, 'message': message};
    } catch (e) {
      return {'success': false, 'message': 'An error occurred'};
    }
  }


  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    try {
      final response = await dioClient.dio.post(
        Urls.register,
        data: {'full_name': name, 'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        return {'success': true, 'data': response.data};
      } else {
        return {
          'success': false,
          'message': 'Registration failed, please try again'
        };
      }
    } on DioError catch (e) {
      debugPrint("DioError register: ${e.response?.data}");
      final data = e.response?.data;

      String message = 'Registration failed';

      if (e.response?.statusCode == 400) {
        if (data != null) {
          if (data['errors'] != null && data['errors'] is List) {
            message = (data['errors'] as List)
                .map((err) => err['message'])
                .join(', ');
          } else if (data['message'] != null) {
            message = data['message'];
          }
        } else {
          message = 'Invalid request';
        }
      } else if (e.response?.statusCode == 500) {
        message = data?['message'] ?? 'Internal server error, please try later';
      } else {
        message = data?['message'] ?? 'Unexpected error occurred';
      }

      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint("Error register: $e");
      return {'success': false, 'message': 'An error occurred'};
    }
  }
}
