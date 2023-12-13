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
