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
