import '../../network/api_service.dart';

class RegisterController {
  Future<void> register(
    String fullName,
    String email,
    String password,
    String phone,
  ) async {
    try {
      final response =
          await ApiService.register(fullName, email, password, phone);
    } catch (e) {
      print('Registration failed: $e');
    }
  }
}
