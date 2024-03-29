import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
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

  static Future<dynamic> getVaccineData({int loggedInUserId = 0}) async {
    Uri uri = Uri.parse('$baseUrl/get_vaccine_data.php');
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
      'contact_no': saveDisease.vaccinatorContactNo,
      'farmer_name': saveDisease.farmerName,
      'farmer_phone': saveDisease.farmerContact,
      'vaccination_status': saveDisease.vaccinationStatus,
      'last_vaccination_date': saveDisease.lastVaccinationDate,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveVaccineDataSecond(
      VaccinationDataSecondRequest saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_vaccination_data_second.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'created_by': saveDisease.createdBy,
      'id': saveDisease.id,
      'population_goats': saveDisease.populationGoats,
      'goats_herds': saveDisease.goatsHerds,
      'population_sheep': saveDisease.populationSheep,
      'sheep_herds': saveDisease.sheepHerds,
      'vaccination_status': saveDisease.vaccinationStatus,
      'last_vaccination_date': saveDisease.lastVaccinationDate,
      'no_of_sheep_vaccinated': saveDisease.noOfGoatsVaccinated,
      'no_of_goats_vaccinated': saveDisease.noOfGoatsVaccinated,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveVaccineDataSheep(
      SaveVaccinationDataSheep saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_vaccination_data_sheep.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'created_by': saveDisease.createdBy,
      'id': saveDisease.id,
      'specie': saveDisease.specie,
      'vaccine_type': saveDisease.vaccineType,
      'sheep_zero_to_three': saveDisease.sheepZeroToThree,
      'sheep_four_to_twelve': saveDisease.sheepFourToTwelve,
      'sheep_four_to_twelve_vaccinated':
          saveDisease.sheepFourToTwelveVaccinated,
      'sheep_thirteen_to_twentyfour': saveDisease.sheepThirteenToTwentyFour,
      'sheep_thirteen_to_twentyfour_vaccinated':
          saveDisease.sheepThirteenToTwentyFourVaccinated,
      'sheep_twentyfour_plus': saveDisease.sheepTwentyFourPlus,
      'sheep_twentyfour_plus_vaccinated':
          saveDisease.sheepTwentyFourPlusVaccinated,
    });

    return await placeApiRequest(request, uri);
  }

  static Future<dynamic> saveVaccineDataGoat(
      SaveVaccinationDataSheep saveDisease) async {
    Uri uri = Uri.parse('$baseUrl/save_vaccination_data_goats.php');
    var request = http.MultipartRequest('POST', uri);
    request.fields.addAll({
      'created_by': saveDisease.createdBy,
      'id': saveDisease.id,
      'specie': saveDisease.specie,
      'vaccine_type': saveDisease.vaccineType,
      'goats_zero_to_three': saveDisease.sheepZeroToThree,
      'goats_four_to_twelve': saveDisease.sheepFourToTwelve,
      'goats_four_to_twelve_vaccinated':
          saveDisease.sheepFourToTwelveVaccinated,
      'goats_thirteen_to_twentyfour': saveDisease.sheepThirteenToTwentyFour,
      'goats_thirteen_to_twentyfour_vaccinated':
          saveDisease.sheepThirteenToTwentyFourVaccinated,
      'goats_twentyfour_plus': saveDisease.sheepTwentyFourPlus,
      'goats_twentyfour_plus_vaccinated':
          saveDisease.sheepTwentyFourPlusVaccinated,
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
