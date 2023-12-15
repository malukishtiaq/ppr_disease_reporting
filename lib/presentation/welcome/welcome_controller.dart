import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import '../../helper/permision_helper.dart';

class WelcomeController extends GetxController {
  final loc.Location location = loc.Location();
  var isLoading = false.obs; // Observable for loading state

  Future<void> getLocationAndNavigate(String route) async {
    isLoading(true);
    try {
      await PermissionHandler.isFor.locationPermission();

      var _currentPosition = await location.getLocation();
      var longitude = _currentPosition.longitude.toString();
      var latitude = _currentPosition.latitude.toString();

      print("Longitude: $longitude, Latitude: $latitude");

      Get.offNamed(route);
    } catch (e) {
      print("Error getting location: $e");
    } finally {
      isLoading(false);
    }
  }
}
