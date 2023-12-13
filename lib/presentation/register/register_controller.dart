import 'dart:convert';

import 'package:ppr_disease_reporting/helper/dialog_helper.dart';
import 'package:get/get.dart';
import '../../base_controller.dart';
import '../../models/registration_result.dart';
import '../../network/api_service.dart';
import '../../network/app_exceptions.dart';

class RegisterController extends GetxController with BaseController {
  Future<RegistrationResult?> register(
    String fullName,
    String cnic,
    String password,
    String phone,
  ) async {
    showLoading('Posting data...');
    try {
      final response =
          await ApiService.register(fullName, cnic, password, phone)
              .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
        }
      });
      hideLoading();
      if (response != null) {
        final decodedResponse = jsonDecode(response);
        return RegistrationResult.fromApiResponse(decodedResponse);
      }
    } catch (e) {
      return null;
    }

    hideLoading();
    return null;
  }
}
