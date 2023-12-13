import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';

class UserController extends GetxController {
  User? _user;

  User? get user => _user;

  Future<void> setUser(User? user, bool rememberMe) async {
    _user = user;
    update();
    if (rememberMe) {
      await saveUserInfo(user);
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null && userId.isNotEmpty) {
      _user = User(id: int.parse(userId));
      update();
    }
  }

  Future<void> saveUserInfo(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user?.id.toString() ?? '');
  }
}
