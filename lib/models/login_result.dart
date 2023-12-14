import 'package:ppr_disease_reporting/models/login_response.dart';

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
