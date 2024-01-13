import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/models/login_response.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/models/login_result.dart';
import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../network/api_service.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';

class LoginController extends GetxController with BaseController {
  final RxBool rememberMe = false.obs;
  final TextEditingController CNICController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String saveCNICToDatabase(String cnicNumber) {
    String cnicWithoutHyphens = cnicNumber.replaceAll('-', '');

    return cnicWithoutHyphens;
  }

  Future<LoginResult> handleLogin() async {
    String CNIC = saveCNICToDatabase(CNICController.text);
    String password = passwordController.text;
    if (kDebugMode) {
      CNIC = '1234123412343';
      password = '1234';
    }
    bool rememberMeValue = rememberMe.value;
    if (CNIC.isEmpty && password.isEmpty) {
      return LoginResult.failure("CNIC and password are required");
    } else if (CNIC.isEmpty) {
      return LoginResult.failure("CNIC is required");
    } else if (password.isEmpty) {
      return LoginResult.failure("Password is required");
    }

    showLoading('Posting data...');

    final response = await ApiService.login(CNIC, password).catchError((error) {
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
        await userController.setUser(loginResponse.user, rememberMeValue);
        return LoginResult.success(loginResponse);
      } else {
        return LoginResult.failure(loginResponse.msg ?? 'Login failed');
      }
    }

    hideLoading();
    return LoginResult.failure('Login failed. Please try again later.');
  }
}
