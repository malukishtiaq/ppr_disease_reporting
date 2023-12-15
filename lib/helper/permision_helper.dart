import 'package:location/location.dart' as loc;

class PermissionHandler {
  PermissionHandler._privateConstructor();
  static final PermissionHandler _isFor =
      PermissionHandler._privateConstructor();
  static PermissionHandler get isFor => _isFor;

  Future<bool> locationPermission({bool openSetting = false}) async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus? _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        _permissionGranted = await location.hasPermission();
        if (_permissionGranted == loc.PermissionStatus.denied) {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == loc.PermissionStatus.granted) {
            return true;
          }
        } else {
          return true;
        }
      }
    } else {
      print('');
    }
    return true;
  }
}
