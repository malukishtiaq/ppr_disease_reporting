class SaveDisease {
  String name;
  String cnic;
  String location;
  String village;
  String phone;
  String province;
  String createdBy;
  String latitude;
  String longitude;

  SaveDisease({
    required this.name,
    required this.cnic,
    required this.location,
    required this.village,
    required this.phone,
    required this.province,
    required this.createdBy,
    required this.latitude,
    required this.longitude,
  });

  factory SaveDisease.fromJson(Map<String, dynamic> json) {
    return SaveDisease(
      name: json['name'] as String,
      cnic: json['cnic'] as String,
      location: json['location'] as String,
      village: json['village'] as String,
      phone: json['phone'] as String,
      province: json['province'] as String,
      createdBy: json['created_by'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cnic': cnic,
      'location': location,
      'village': village,
      'phone': phone,
      'province': province,
      'created_by': createdBy,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
