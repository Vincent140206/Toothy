import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/auth_services.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthServices _registerService = AuthServices();
  String? errorMessage;

  Future<bool> register(String name, String email, String password) async {
    try {
      final result = await _registerService.register(name, email, password);

      if (result['success']) {
        return true;
      } else {
        errorMessage = result['message'] ?? 'Registration failed';
        return false;
      }
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }

}

class LoginViewModel {
  final AuthServices _loginService = AuthServices();
  String? errorMessage;

  Future<bool> login(String email, String password) async {
    try {
      final result = await _loginService.login(email, password);

      if (result['success'] == true) {
        final token = result['token']?.toString();
        if (token == null || token.isEmpty) {
          errorMessage = 'Token kosong';
          return false;
        }

        print('Token tersimpan: $token');
        return true;
      } else {
        errorMessage = result['message'] ?? 'Login gagal';
        return false;
      }
    } catch (e) {
      errorMessage = 'Terjadi kesalahan: $e';
      return false;
    }
  }

}