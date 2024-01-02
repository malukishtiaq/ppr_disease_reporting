class VaccinationDataRequest {
  double latitude;
  double longitude;
  String province;
  String district;
  String tehsil;
  String village;
  String vaccinatorName;
  String designation;
  String hospital;
  String createdBy;

  VaccinationDataRequest({
    required this.latitude,
    required this.longitude,
    required this.province,
    required this.district,
    required this.tehsil,
    required this.village,
    required this.vaccinatorName,
    required this.designation,
    required this.hospital,
    required this.createdBy,
  });

  Map<String, String> toMap() {
    return {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'province': province,
      'district': district,
      'tehsil': tehsil,
      'village': village,
      'vaccinator_name': vaccinatorName,
      'designation': designation,
      'hospital': hospital,
      'created_by': createdBy,
    };
  }
}
