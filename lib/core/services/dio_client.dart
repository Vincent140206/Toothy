import 'package:dio/dio.dart';

import '../constants/url.dart';
import '../utils/token_storage.dart';


class DioClient {
  final Dio dio;
  Urls urls = Urls();

  DioClient._internal(this.dio);

  factory DioClient() {
    final baseUrl = Urls.baseUrl;
    final dio = Dio(BaseOptions(
      baseUrl: 'https://$baseUrl/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    )) ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));

    return DioClient._internal(dio);
  }
}