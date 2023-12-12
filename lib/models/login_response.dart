// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  User? user;
  String? msg;

  LoginResponse({
    this.success,
    this.user,
    this.msg,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        success: json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "user": user?.toJson(),
        "msg": msg,
      };
}

class User {
  int? id;
  String? name;
  String? cnic;
  String? password;
  String? phone;
  int? accountType;
  dynamic provinceId;
  dynamic districtId;
  dynamic labId;
  String? userCode;
  int? userStatus;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic createdIp;
  dynamic updatedIp;

  User({
    this.id,
    this.name,
    this.cnic,
    this.password,
    this.phone,
    this.accountType,
    this.provinceId,
    this.districtId,
    this.labId,
    this.userCode,
    this.userStatus,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
    this.createdIp,
    this.updatedIp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        cnic: json["cnic"],
        password: json["password"],
        phone: json["phone"],
        accountType: json["account_type"],
        provinceId: json["province_id"],
        districtId: json["district_id"],
        labId: json["lab_id"],
        userCode: json["user_code"],
        userStatus: json["user_status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdIp: json["created_ip"],
        updatedIp: json["updated_ip"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cnic": cnic,
        "password": password,
        "phone": phone,
        "account_type": accountType,
        "province_id": provinceId,
        "district_id": districtId,
        "lab_id": labId,
        "user_code": userCode,
        "user_status": userStatus,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_ip": createdIp,
        "updated_ip": updatedIp,
      };
}
