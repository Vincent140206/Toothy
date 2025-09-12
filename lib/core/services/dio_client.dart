import 'package:dio/dio.dart';
import '../../main.dart';
import '../../presentation/views/auth/view/login_screen.dart';
import '../constants/url.dart';
import '../utils/token_storage.dart';
import 'package:flutter/material.dart';


class DioClient {
  final Dio dio;
  Urls urls = Urls();

  DioClient._internal(this.dio);

  factory DioClient() {
    final baseUrl = Urls.baseUrl;
    final dio = Dio(BaseOptions(
      baseUrl: 'https://$baseUrl/',
      connectTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      validateStatus: (status) => true,
      headers: {'Content-Type': 'application/json'},
    )) ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await TokenStorage.getToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioError err, handler) async {
          if (err.response?.statusCode == 401) {
            final message = err.response?.data['message'] ?? '';

            if (message.contains('Invalid token') || message.contains('No token provided')) {
              await TokenStorage.clearToken();
              navigatorKey.currentState?.pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
              );
            }
          }
          return handler.next(err);
        },
      ),
    );

    return DioClient._internal(dio);
  }
}