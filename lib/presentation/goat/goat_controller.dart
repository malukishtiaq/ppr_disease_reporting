import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/presentation/home/home_page.dart';
import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../models/vaccination_data_second_request.dart';
import '../../network/api_service.dart';
import 'package:get/get.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';
import '../../routes/app_routes.dart';

class GoatDataController extends GetxController with BaseController {
  final TextEditingController ageZeroController = TextEditingController();
  final TextEditingController age4To12Controller = TextEditingController();
  final TextEditingController age4To12TwoVaccinatedController =
      TextEditingController();
  final TextEditingController age12To24Controller = TextEditingController();
  final TextEditingController age12To24TwoVaccinatedController =
      TextEditingController();
  final TextEditingController moreThen24Controller = TextEditingController();
  final TextEditingController moreThen24VaccinatedController =
      TextEditingController();

  Future<void> saveVaccineData(SaveVaccinationDataSheep saveDisease) async {
    try {
      showLoading('Saving data...');
      final response =
          await ApiService.saveVaccineDataGoat(saveDisease).catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
        }
      });

      hideLoading();

      final decodedResponse = jsonDecode(response);
      if (decodedResponse['success'] == true) {
        resetData();
        onTapScreenTitleAndRemoveUntil();
      } else {
        DialogHelper.showErrorDialog(description: 'Failed to save data');
      }
    } catch (e) {
      hideLoading();
      resetData();
      onTapScreenTitleAndRemoveUntil();
    }
  }

  void onTapScreenTitleAndRemoveUntil() {
    try {
      Get.offUntil(
        ModalRoute.withName(AppRoutes.homePage) as Route,
        (route) => false,
      );
    } catch (e) {
      Get.offAll(HomePage());
    }
  }

  Future<void> onSaveDisease() async {
    final userController = Get.find<UserController>();
    if (userController.user != null) {
      SaveVaccinationDataSheep saveDisease = SaveVaccinationDataSheep(
        id: getParamId(),
        specie: getSpecieId(),
        vaccineType: getVaccineId(),
        sheepZeroToThree: ageZeroController.text,
        sheepFourToTwelve: age4To12Controller.text,
        sheepFourToTwelveVaccinated: age4To12TwoVaccinatedController.text,
        sheepThirteenToTwentyFour: age12To24Controller.text,
        sheepThirteenToTwentyFourVaccinated:
            age12To24TwoVaccinatedController.text,
        sheepTwentyFourPlus: moreThen24Controller.text,
        sheepTwentyFourPlusVaccinated: moreThen24VaccinatedController.text,
        createdBy: userController.user!.id.toString(),
      );
      await saveVaccineData(saveDisease);
    }
  }

  String getParamId() {
    var arguments = Get.arguments;
    if (arguments != null &&
        arguments is Map<String, dynamic> &&
        arguments.containsKey('id')) {
      return arguments['id'].toString();
    }
    return '';
  }

  String getSpecieId() {
    var arguments = Get.arguments;
    if (arguments != null &&
        arguments is Map<String, dynamic> &&
        arguments.containsKey('speci')) {
      return arguments['speci'].toString();
    }
    return '';
  }

  String getVaccineId() {
    var arguments = Get.arguments;
    if (arguments != null &&
        arguments is Map<String, dynamic> &&
        arguments.containsKey('vaccine')) {
      return arguments['vaccine'].toString();
    }
    return '';
  }

  @override
  void onClose() {
    resetData();

    super.onClose();
  }

  Future<void> resetData() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      ageZeroController.clear();
      age4To12Controller.clear();
      age12To24Controller.clear();
      moreThen24Controller.clear();
      age4To12TwoVaccinatedController.clear();
      age12To24TwoVaccinatedController.clear();
      moreThen24VaccinatedController.clear();
    } catch (e) {
      print('');
    }
  }
}
