import '../../base_controller.dart';
import 'package:get/get.dart';
import '../../helper/dialog_helper.dart';
import '../../routes/app_routes.dart';

class SpeciVaccineController extends GetxController with BaseController {
  final RxString selectedSpeciesStatus = 'Not Selected'.obs;
  final RxString selectedVaccineType = 'Not Selected'.obs;
  final List<String> speciesStatusOptions = [
    'Not Selected',
    'Sheep',
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
          'speci': selectedSpeciesStatus.value,
          'vaccine': selectedVaccineType.value
        },
      );
    }
  }

  String get getPath {
    if (selectedSpeciesStatus.value == 'Sheep') return AppRoutes.sheep;
    if (selectedSpeciesStatus.value == 'Goat') return AppRoutes.goat;
    if (selectedSpeciesStatus.value == 'Mixed')
      return AppRoutes.mixed;
    else
      return AppRoutes.homePage;
  }
}
