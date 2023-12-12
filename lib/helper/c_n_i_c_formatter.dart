import 'package:flutter/services.dart';

class CNICFormatter extends TextInputFormatter {
  static const int maxLength = 15;

  static String saveCNICToDatabase(String cnicNumber) {
    String cnicWithoutHyphens = cnicNumber.replaceAll('-', '');

    return cnicWithoutHyphens;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String formattedValue = _getFormattedCNIC(newValue.text);

    return TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String _getFormattedCNIC(String value) {
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length > 5) {
      digitsOnly = '${digitsOnly.substring(0, 5)}-${digitsOnly.substring(5)}';
    }

    if (digitsOnly.length > 13) {
      digitsOnly = '${digitsOnly.substring(0, 13)}-${digitsOnly.substring(13)}';
    }
    if (digitsOnly.length > maxLength) {
      digitsOnly = digitsOnly.substring(0, maxLength);
    }

    return digitsOnly;
  }
}
