import '../../base_controller.dart';
import 'package:get/get.dart';
import '../../helper/dialog_helper.dart';
import '../../routes/app_routes.dart';

class SpeciVaccineController extends GetxController with BaseController {
  final RxString selectedSpeciesStatus = 'Not Selected'.obs;
  final RxString selectedVaccineType = 'Not Selected'.obs;
  final List<String> speciesStatusOptions = [
    'Not Selected',
    'Sheeps',
    'Goats',
    'Mixed'
  ];
  final List<String> vaccineTypeOptions = [
    'Not Selected',
    'Routine Vaccination',
    'Emergency Vaccination',
    'Ring Vaccination'
  ];

  void setSpeciesStatus(String status) {
    selectedSpeciesStatus.value = status;
    update();
  }

  void setSelectedVaccineStatus(String status) {
    selectedVaccineType.value = status;
    update();
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

  void navigateToHeardPage() {
    if (selectedSpeciesStatus.value == 'Not Selected') {
      DialogHelper.showErrorDialog(
        title: 'Error',
        description: 'Please select Species Status',
      );
    } else if (selectedVaccineType.value == 'Not Selected') {
      DialogHelper.showErrorDialog(
        title: 'Error',
        description: 'Please select Vaccine Type',
      );
    } else {
      Get.toNamed(
        getPath,
        arguments: {
          'id': getParamId(),
          'speci': getSelectedSpeci,
          'vaccine': getSelectedVaccine
        },
      );
      resetValues();
    }
  }

  String get getSelectedVaccine {
    if (selectedVaccineType.value == 'Routine Vaccination')
      return '1';
    else if (selectedVaccineType.value == 'Emergency Vaccination')
      return '2';
    else if (selectedVaccineType.value == 'Ring Vaccination')
      return '3';
    else
      return '0';
  }

  String get getSelectedSpeci {
    if (selectedSpeciesStatus.value == 'Sheeps')
      return '1';
    else if (selectedSpeciesStatus.value == 'Goats')
      return '2';
    else if (selectedSpeciesStatus.value == 'Mixed')
      return '3';
    else
      return '0';
  }

  String get getPath {
    if (selectedSpeciesStatus.value == 'Goats') {
      return AppRoutes.goat;
    }
    return AppRoutes.sheep;
  }

  void resetValues() {
    selectedSpeciesStatus.value = 'Not Selected';
    selectedVaccineType.value = 'Not Selected';
  }
}
