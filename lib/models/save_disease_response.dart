class SaveDiseaseResponse {
  final bool success;
  final String msg;

  SaveDiseaseResponse({
    required this.success,
    required this.msg,
  });

  factory SaveDiseaseResponse.fromJson(Map<String, dynamic> json) {
    return SaveDiseaseResponse(
      success: json['success'] as bool,
      msg: json['msg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'msg': msg,
    };
  }
}
