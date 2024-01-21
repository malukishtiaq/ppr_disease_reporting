import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../base_controller.dart';
import '../../core/app_export.dart';
import '../../helper/dialog_helper.dart';
import '../../models/vaccination_data.dart';
import '../../network/api_service.dart';
import 'package:get/get.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';

class VaccineController extends GetxController with BaseController {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController farmerNameController = TextEditingController();
  final TextEditingController farmerContactController = TextEditingController();
  final TextEditingController villageNameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController tehsilController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  final TextEditingController lastVaccineController = TextEditingController();
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxString selectedAddress = ''.obs;
  final RxBool showMap = true.obs;
  final RxBool isVaccinated = false.obs;
  final RxString selectedVaccineStatus = 'Unknown'.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final List<String> vaccineStatusOptions = [
    'Vaccinated',
    'Unvaccinated',
    'Unknown'
  ];

  void setSelectedVaccineStatus(String status) {
    selectedVaccineStatus.value = status;
    if (status == "Vaccinated") {
      isVaccinated.value = true;
    } else {
      isVaccinated.value = false;
    }
    update();
  }

  Future<void> nextClicked() async {
    showMap.toggle();
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

  Future<void> saveVaccineData(VaccinationData saveDisease) async {
    try {
      showLoading('Saving data...');
      final response = await ApiService.saveVaccineDataFirst(saveDisease)
          .catchError((error) {
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
        await resetData();
        navigateToHeardPage(decodedResponse);
      } else {
        DialogHelper.showErrorDialog(description: 'Failed to save data');
      }
    } catch (e) {
      Get.back();
      hideLoading();
    }
  }

  void navigateToHeardPage(decodedResponse) {
    Get.toNamed(
      AppRoutes.speciVaccine,
      arguments: {'id': decodedResponse["id"]},
    );
  }

  static String saveCNICToDatabase(String cnicNumber) {
    String cnicWithoutHyphens = cnicNumber.replaceAll('-', '');

    return cnicWithoutHyphens;
  }

  Future<void> onSaveDisease() async {
    final userController = Get.find<UserController>();

    if (userController.user != null) {
      final LatLng position = markers.isNotEmpty
          ? markers.first.position
          : LatLng(30.3753, 69.3451);

      VaccinationData saveDisease = VaccinationData(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        village: villageNameController.text,
        province: placemark.administrativeArea ?? "",
        district: placemark.subAdministrativeArea ?? "",
        tehsil: tehsilController.text,
        vaccinatorName: fullNameController.text,
        designation: designationController.text,
        hospital: hospitalController.text,
        phoneNo: contactController.text,
        vaccinationStatus: getStatusValue,
        lastVaccinationDate: lastVaccineController.text,
        farmerContact: farmerContactController.text,
        farmerName: farmerNameController.text,
        createdBy: userController.user?.id.toString() ?? "",
      );

      await saveVaccineData(saveDisease);
    }
  }

  String get getStatusValue {
    String status = selectedVaccineStatus.value;
    if (status == "Vaccinated") {
      return "1";
    } else if (status == "Unvaccinated") {
      return "2";
    } else {
      return "3";
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.value = controller;
  }

  void onMapTap(LatLng latLng) {
    markers.clear();
    update();

    _addMarker(latLng);
    update();
  }

  void _addMarker(LatLng latLng) {
    markers.add(
      Marker(
        markerId: MarkerId('selected_location'),
        position: latLng,
        draggable: true,
        onDragEnd: (newPosition) {
          _onMarkerDragEnd(newPosition);
        },
      ),
    );
    _getAddressFromLatLng(latLng);
  }

  void _onMarkerDragEnd(LatLng newPosition) {
    _addMarker(newPosition);
  }

  Placemark placemark = new Placemark();
  Future<void> _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        placemark = placemarks.first;
        selectedAddress.value = getAddress(placemark);
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
  }

  String getAddress(Placemark placemark) {
    List<String> addressParts = [];

    if (placemark.locality != null && placemark.locality!.isNotEmpty) {
      addressParts.add(placemark.locality!);
    }
    if (placemark.subAdministrativeArea != null &&
        placemark.subAdministrativeArea!.isNotEmpty) {
      addressParts.add(placemark.subAdministrativeArea!);
    }
    if (placemark.administrativeArea != null &&
        placemark.administrativeArea!.isNotEmpty) {
      addressParts.add(placemark.administrativeArea!);
    }
    if (placemark.postalCode != null && placemark.postalCode!.isNotEmpty) {
      addressParts.add(placemark.postalCode!);
    }
    if (placemark.country != null && placemark.country!.isNotEmpty) {
      addressParts.add(placemark.country!);
    }

    return addressParts.join(', ');
  }

  @override
  void onClose() {
    resetData();

    super.onClose();
  }

  Future<void> resetData() async {
    try {
      await Future.delayed(Duration.zero);
      markers.clear();
      selectedAddress.value = '';
      showMap.value = true;
      fullNameController.clear();
      villageNameController.clear();
      contactController.clear();
      tehsilController.clear();
      designationController.clear();
      hospitalController.clear();
    } catch (e) {
      print('');
    }
  }
}
