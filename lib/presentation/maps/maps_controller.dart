import '../../network/api_service.dart';

class LoginController {
  Future<void> handleLogin(String username, String password) async {
    try {
      final response = await ApiService.login(username, password);
    } catch (e) {
      print('Login failed: $e');
    }
  }
}
