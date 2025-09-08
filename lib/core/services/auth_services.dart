import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../presentation/views/auth/view/login_screen.dart';
import '../../presentation/views/home/view/main_screen.dart';
import '../constants/url.dart';
import 'dio_client.dart';

class AuthServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    void _goToLogin() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }

    if (token != null) {
      try {
        final response = await dioClient.dio.get(Urls.checkSession);

        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreen()),
          );
        } else if (response.statusCode == 401) {
          final message = response.data['message'] ?? '';

          if (message.contains('Invalid token')) {
            await prefs.clear();
            _goToLogin();
          } else if (message.contains('No token provided')) {
            _goToLogin();
          } else {
            await prefs.clear();
            _goToLogin();
          }
        } else {
          await prefs.clear();
          _goToLogin();
        }
      } on DioError catch (e) {
        debugPrint("DioError checkLoginStatus: ${e.response?.data}");
        await prefs.clear();
        _goToLogin();
      } catch (e) {
        debugPrint("Error checkLoginStatus: $e");
        await prefs.clear();
        _goToLogin();
      }
    } else {
      _goToLogin();
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
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', data['token']);
        return {'success': true, 'data': response.data};
      } else {
        return {'success': false, 'message': 'Login failed'};
      }
    } on DioError catch (e) {
      debugPrint("DioError login: ${e.response?.data}");
      final data = e.response?.data;

      String message = 'Login failed';
      if (data != null) {
        if (data['errors'] != null && data['errors'] is List) {
          message = (data['errors'] as List)
              .map((err) => err['message'])
              .join(', ');
        } else if (data['message'] != null) {
          message = data['message'];
        }
      }

      return {'success': false, 'message': message};
    } catch (e) {
      debugPrint("Error login: $e");
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
