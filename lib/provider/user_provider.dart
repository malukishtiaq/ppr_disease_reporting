import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_response.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> setUser(User? user, bool rememberme) async {
    _user = user;
    notifyListeners();
    if (rememberme) {
      await saveUserInfo(user);
    }
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId != null && userId != "") {
      _user = User(id: int.parse(userId));
      notifyListeners();
    }
  }

  Future<void> saveUserInfo(User? user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', user?.id.toString() ?? '');
  }
}
