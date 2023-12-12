import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://ppr-nvl.gov.pk/epinode/api';

  static Future<dynamic> login(String username, String password) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/login.php'),
    );
    request.fields.addAll({'cnic': username, 'password': password});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      return body;
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

  static Future<dynamic> register(
    String fullName,
    String cnic,
    String password,
    String phone,
  ) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/signup.php'),
    );
    request.fields.addAll({
      'name': fullName,
      'cnic': cnic,
      'phone': phone,
      'password': password,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      return body;
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }

  static Future<dynamic> getData({int loggedInUserId = 0}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/get_data.php'));
    request.fields.addAll({'user_id': loggedInUserId.toString()});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var body = await response.stream.bytesToString();
      return body;
    } else {
      print(response.reasonPhrase);
    }
    return null;
  }
}
