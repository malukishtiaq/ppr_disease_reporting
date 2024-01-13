import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ppr_disease_reporting/presentation/home/home_page.dart';
import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../models/vaccination_data_second_request.dart';
import '../../network/api_service.dart';
import 'package:get/get.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';
import '../../routes/app_routes.dart';

class HeardController extends GetxController with BaseController {
  final RxString selectedAddress = ''.obs;
  final TextEditingController sheepPopController = TextEditingController();
  final TextEditingController goatPopController = TextEditingController();
  final TextEditingController noSheepController = TextEditingController();
  final TextEditingController noGoatController = TextEditingController();
  final TextEditingController vaccineStatusController = TextEditingController();
  final TextEditingController lastVaccineController = TextEditingController();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final RxString selectedVaccineStatus = 'Unknown'.obs;
  final List<String> vaccineStatusOptions = [
    'Vaccinated',
    'Unvaccinated',
    'Unknown'
  ];

  void setSelectedVaccineStatus(String status) {
    selectedVaccineStatus.value = status;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
      lastVaccineController.text = formatDate(picked);
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<void> saveVaccineData(VaccinationDataSecondRequest saveDisease) async {
    try {
      //showLoading('Saving data...');
      final response = await ApiService.saveVaccineDataSecond(saveDisease)
          .catchError((error) {
        if (error is BadRequestException) {
          var apiError = json.decode(error.message!);
          DialogHelper.showErrorDialog(description: apiError["reason"]);
        } else {
          handleError(error);
        }
      });

      //hideLoading();

      final decodedResponse = jsonDecode(response);
      if (decodedResponse['success'] == true) {
        resetData();
        onTapScreenTitleAndRemoveUntil();
      } else {
        DialogHelper.showErrorDialog(description: 'Failed to save data');
      }
    } catch (e) {
      //hideLoading();
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

  static String saveCNICToDatabase(String cnicNumber) {
    String cnicWithoutHyphens = cnicNumber.replaceAll('-', '');

    return cnicWithoutHyphens;
  }

  Future<void> onSaveDisease() async {
    final userController = Get.find<UserController>();
    String id = getParamId();
    if (userController.user != null) {
      VaccinationDataSecondRequest saveDisease = VaccinationDataSecondRequest(
        id: id,
        noOfSheepVaccinated: noSheepController.text,
        noOfGoatsVaccinated: noGoatController.text,
        populationGoats: goatPopController.text,
        populationSheep: sheepPopController.text,
        lastVaccinationDate: lastVaccineController.text,
        vaccinationStatus: noSheepController.text,
        createdBy: userController.user?.id.toString() ?? "",
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

  @override
  void onClose() {
    resetData();

    super.onClose();
  }

  Future<void> resetData() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      selectedAddress.value = '';
      sheepPopController.clear();
      goatPopController.clear();
      noSheepController.clear();
      noGoatController.clear();
      vaccineStatusController.clear();
      lastVaccineController.clear();
      selectedDate.value = DateTime.now();
      selectedVaccineStatus.value = 'Unknown';
    } catch (e) {
      print('');
    }
  }
}
