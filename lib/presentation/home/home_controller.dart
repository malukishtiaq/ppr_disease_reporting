import 'dart:convert';

import '../../network/api_service.dart';

class HomeController {
  Future<DataResponse?> getData(int loggedInUserId) async {
    try {
      final response = await ApiService.getData(loggedInUserId: loggedInUserId);
      final decodedResponse = jsonDecode(response);
      if (decodedResponse['success'] == true) {
        return DataResponse.fromJson(decodedResponse);
      } else {
        return null;
      }
    } catch (e) {
      print('Failed to fetch data: $e');
      return null;
    }
  }
}

class DataResponse {
  bool? success;
  int? outbreaksData;
  int? positiveOutbreaksData;
  int? negativeOutbreaksData;
  String? msg;

  DataResponse({
    this.success,
    this.outbreaksData,
    this.positiveOutbreaksData,
    this.negativeOutbreaksData,
    this.msg,
  });

  factory DataResponse.fromJson(Map<String, dynamic> json) => DataResponse(
        success: json['success'],
        outbreaksData: json['outbreaks_data'],
        positiveOutbreaksData: json['positive_outbreaks_data'],
        negativeOutbreaksData: json['negative_outbreaks_data'],
        msg: json['msg'],
      );
}
