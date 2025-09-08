import 'package:shared_preferences/shared_preferences.dart';
import 'package:toothy/views/home/view/main_screen.dart';
import 'package:flutter/material.dart';
import '../../views/auth/view/login_screen.dart';
import '../constants/url.dart';
import 'dio_client.dart';
import 'package:dio/dio.dart';

class AuthServices {
  final dioClient = DioClient();
  Urls urls = Urls();

  Future<void> checkLoginStatus(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await dioClient.dio.get(
          Urls.checkSession,
          options: Options(
            headers: { 'Authorization': 'Bearer $token' },
          ),
        );

        if (response.statusCode == 201) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainScreen()),
          );
        } else {
          await prefs.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          );
        }
      } catch (e) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}