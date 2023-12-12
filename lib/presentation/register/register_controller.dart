import 'dart:convert';

import '../../network/api_service.dart';

class RegisterController {
  Future<RegistrationResult> register(
    String fullName,
    String cnic,
    String password,
    String phone,
  ) async {
    try {
      var response = await ApiService.register(fullName, cnic, password, phone);
      print('');
      final decodedResponse = jsonDecode(response);
      return RegistrationResult.fromApiResponse(decodedResponse);
    } catch (e) {
      print('Registration failed: $e');
      throw e; // Re-throw the exception to propagate it to the caller
    }
  }
}

// Create a class to represent the registration result
class RegistrationResult {
  final bool success;
  final String message;

  RegistrationResult(this.success, this.message);

  // Factory method to create a result object from an API response
  factory RegistrationResult.fromApiResponse(Map<String, dynamic> response) {
    // Process the API response and create a result object
    final success = response['success'] ?? false;
    final message = response['msg'] ?? 'Unknown error';

    // Additional handling for a specific error condition
    if (!success &&
        message.contains('User against this CNIC already exists.')) {
      return RegistrationResult(false,
          'User with this CNIC already exists. Please use a different CNIC.');
    }

    return RegistrationResult(success, message);
  }
}
