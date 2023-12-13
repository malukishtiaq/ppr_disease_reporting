import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/models/login_response.dart';
import 'package:get/get.dart';
import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../network/api_service.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';

class LoginController extends GetxController with BaseController {
  Future<LoginResult> handleLogin(
      String username, String password, bool rememberme) async {
    showLoading('Posting data...');

    final response =
        await ApiService.login(username, password).catchError((error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    });

    if (response != null) {
      final LoginResponse loginResponse =
          loginResponseFromJson(response.toString());
      hideLoading();
      if (loginResponse.success != null && loginResponse.success!) {
        final userController = Get.find<UserController>();
        await userController.setUser(loginResponse.user, rememberme);
        return LoginResult.success(loginResponse);
      } else {
        return LoginResult.failure(loginResponse.msg ?? 'Login failed');
      }
    }

    hideLoading();
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
