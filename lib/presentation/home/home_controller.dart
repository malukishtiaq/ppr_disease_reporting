import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:ppr_disease_reporting/models/data_response.dart';

import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../network/api_service.dart';

import 'package:get/get.dart';

import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';

class HomeController extends GetxController with BaseController {
  var dataResponse = Rx<DataResponse?>(null);
  var vaccineDataResponse = Rx<VaccineDataResponse?>(null);
  var isUserFarmar = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    getData();
    getVaccineData();
  }

  Future<void> getData() async {
    final userController = Get.find<UserController>();
    isUserFarmar.value = kDebugMode
        ? false
        : userController.user?.accountType != 4
            ? true
            : false;
    try {
      final response = await ApiService.getData(
          loggedInUserId: userController.user?.id ?? 0);
      final decodedResponse = jsonDecode(response);
      if (decodedResponse['success'] == true) {
        dataResponse.value = DataResponse.fromJson(decodedResponse);
      } else {
        dataResponse.value = null;
      }
    } catch (error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    } finally {
      hideLoading();
    }
    update();
  }

  Future<void> getVaccineData() async {
    final userController = Get.find<UserController>();
    try {
      final response = await ApiService.getVaccineData(
          loggedInUserId: userController.user?.id ?? 0);
      final decodedResponse = jsonDecode(response);
      if (decodedResponse['success'] == true) {
        vaccineDataResponse.value =
            VaccineDataResponse.fromJson(decodedResponse);
      } else {
        vaccineDataResponse.value = null;
      }
    } catch (error) {
      if (error is BadRequestException) {
        var apiError = json.decode(error.message!);
        DialogHelper.showErrorDialog(description: apiError["reason"]);
      } else {
        handleError(error);
      }
    } finally {
      hideLoading();
    }
    update();
  }
}
