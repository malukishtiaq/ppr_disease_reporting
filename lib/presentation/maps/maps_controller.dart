import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ppr_disease_reporting/models/save_disease.dart';
import '../../base_controller.dart';
import '../../helper/dialog_helper.dart';
import '../../network/api_service.dart';
import 'package:get/get.dart';
import '../../network/app_exceptions.dart';
import '../../provider/user_controller.dart';

class MapsController extends GetxController with BaseController {
  final RxSet<Marker> markers = <Marker>{}.obs;
  final RxString selectedAddress = ''.obs;
  final RxBool showMap = true.obs;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController villageNameController = TextEditingController();
  final TextEditingController CNICController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final Rx<GoogleMapController?> mapController = Rx<GoogleMapController?>(null);
  Future<void> nextClicked() async {
    showMap.toggle();
  }

  Future<void> saveDiseaseData(SaveDisease saveDisease) async {
    try {
      showLoading('Saving data...');
      final response =
          await ApiService.saveDiseaseData(saveDisease).catchError((error) {
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
        Get.back();
      } else {
        DialogHelper.showErrorDialog(description: 'Failed to save data');
      }
    } catch (e) {
      Get.back();
      hideLoading();
    }
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

      SaveDisease saveDisease = SaveDisease(
        name: fullNameController.text,
        cnic: saveCNICToDatabase(CNICController.text),
        location: placemark.toJson().toString(),
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        village: villageNameController.text ?? "",
        phone: phoneController.text,
        province: placemark.administrativeArea ?? "",
        district: placemark.subAdministrativeArea ?? "",
        createdBy: userController.user?.id.toString() ?? "",
      );

      await saveDiseaseData(saveDisease);
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

//
//   @override
//   void onClose() {
//     markers.clear();
//     selectedAddress.value = '';
//     showMap.value = true;
//     fullNameController.clear();
//     villageNameController.clear();
//     CNICController.clear();
//     passwordController.clear();
//     phoneController.clear();
//     mapController.value = null;
//
//     super.onClose();
//   }
  @override
  void onClose() {
    resetData();
    mapController.value = null;

    super.onClose();
  }

  Future<void> resetData() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      markers.clear();
      selectedAddress.value = '';
      showMap.value = true;
      fullNameController.clear();
      villageNameController.clear();
      CNICController.clear();
      passwordController.clear();
      phoneController.clear();
    } catch (e) {
      print('');
    }
  }
}
