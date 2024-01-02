import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ppr_disease_reporting/models/save_disease.dart';

import '../models/vaccination_data.dart';
import '../models/vaccination_data_second_request.dart';
import 'app_exceptions.dart';

class ApiService {
  static const String baseUrl = 'https://ppr-nvl.gov.pk/epinode/api';

  static Future<dynamic> login(String username, String password) async {
    var uri = Uri.parse('$baseUrl/login.php');
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/login.php'),
    );
    request.fields.addAll({'cnic': username, 'password': password});

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> register(
    String fullName,
    String cnic,
    String password,
    String phone,
  ) async {
    Uri uri = Uri.parse('$baseUrl/signup.php');
    var request = http.MultipartRequest(
      'POST',
      uri,
    );
    request.fields.addAll({
      'name': fullName,
      'cnic': cnic,
      'phone': phone,
      'password': password,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> getData({int loggedInUserId = 0}) async {
    Uri uri = Uri.parse('$baseUrl/get_data.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({'user_id': loggedInUserId.toString()});

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveDiseaseData(SaveDisease saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_disease_data.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'name': saveDisease.name,
      'cnic': saveDisease.cnic,
      'location': saveDisease.location,
      'latitude': saveDisease.latitude,
      'longitude': saveDisease.longitude,
      'village': saveDisease.village,
      'phone': saveDisease.phone,
      'province': saveDisease.province,
      'district': saveDisease.district,
      'created_by': saveDisease.createdBy,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveVaccineDataFirst(
      VaccinationData saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_vaccination_data_first.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'village': saveDisease.village,
      'province': saveDisease.province,
      'district': saveDisease.district,
      'created_by': saveDisease.createdBy,
      'latitude': saveDisease.latitude,
      'longitude': saveDisease.longitude,
      'tehsil': saveDisease.tehsil,
      'vaccinator_name': saveDisease.vaccinatorName,
      'designation': saveDisease.designation,
      'hospital': saveDisease.hospital,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveVaccineDataSecond(
      VaccinationDataSecondRequest saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_vaccination_data_second.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      // 'village': saveDisease.village,
      // 'province': saveDisease.province,
      // 'district': saveDisease.district,
      'created_by': saveDisease.createdBy,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> placeApiRequest(
      http.MultipartRequest request, Uri uri) async {
    try {
      http.StreamedResponse response = await request.send();
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection', uri.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in time', uri.toString());
    }
  }

  static dynamic _processResponse(response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        var body = await response.stream.bytesToString();
        return body;
      case 400:
        throw BadRequestException(
            response.stream.bytesToString(), response.request!.url.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(
            response.stream.bytesToString(), response.request!.url.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured with code : ${response.statusCode}',
            response.request!.url.toString());
    }
  }
}
