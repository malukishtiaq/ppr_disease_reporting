import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ppr_disease_reporting/models/login_response.dart';

import '../../network/api_service.dart';
import '../../provider/user_provider.dart';

class LoginController {
  Future<LoginResult> handleLogin(String username, String password,
      BuildContext context, bool rememberme) async {
    try {
      final response = await ApiService.login(username, password);
      if (response != null) {
        final LoginResponse loginResponse =
            loginResponseFromJson(response.toString());

        if (loginResponse.success != null && loginResponse.success!) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          await userProvider.setUser(loginResponse.user, rememberme);
          return LoginResult.success(loginResponse);
        } else {
          return LoginResult.failure(loginResponse.msg ?? 'Login failed');
        }
      }
    } catch (e) {
      print('Login failed: $e');
    }

    return LoginResult.failure('Login failed. Please try again later.');
  }
}

class LoginResult {
  final bool success;
  final String? message;
  final LoginResponse? loginResponse;

  LoginResult({
    required this.success,
    this.message,
    this.loginResponse,
  });

  factory LoginResult.success(LoginResponse loginResponse) {
    return LoginResult(
      success: true,
      loginResponse: loginResponse,
    );
  }

  factory LoginResult.failure(String message) {
    return LoginResult(
      success: false,
      message: message,
    );
  }
}
