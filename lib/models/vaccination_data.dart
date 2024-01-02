class VaccinationData {
  String latitude;
  String longitude;
  String province;
  String district;
  String tehsil;
  String village;
  String vaccinatorName;
  String designation;
  String hospital;
  String populationGoats;
  String goatsHerds;
  String populationSheep;
  String sheepHerds;
  String vaccinationStatus;
  String lastVaccinationDate;
  String totalDosesIssued;
  String issuedBy;
  String totalDosesReceived;
  String receivedBy;
  String totalDosesDispensed;
  String dosesConsumed;
  String dosesWasted;
  String dosesReturned;
  String vaccineBalance;
  String storeIncharge;
  String farmerName;
  String phoneNo;
  String noOfSheepVaccinated;
  String noOfGoatsVaccinated;
  String createdBy;

  VaccinationData({
    this.latitude = '',
    this.longitude = '',
    this.province = '',
    this.district = '',
    this.tehsil = '',
    this.village = '',
    this.vaccinatorName = '',
    this.designation = '',
    this.hospital = '',
    this.populationGoats = '',
    this.goatsHerds = '',
    this.populationSheep = '',
    this.sheepHerds = '',
    this.vaccinationStatus = '',
    this.lastVaccinationDate = '',
    this.totalDosesIssued = '',
    this.issuedBy = '',
    this.totalDosesReceived = '',
    this.receivedBy = '',
    this.totalDosesDispensed = '',
    this.dosesConsumed = '',
    this.dosesWasted = '',
    this.dosesReturned = '',
    this.vaccineBalance = '',
    this.storeIncharge = '',
    this.farmerName = '',
    this.phoneNo = '',
    this.noOfSheepVaccinated = '',
    this.noOfGoatsVaccinated = '',
    this.createdBy = '',
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'province': province,
      'district': district,
      'tehsil': tehsil,
      'village': village,
      'vaccinator_name': vaccinatorName,
      'designation': designation,
      'hospital': hospital,
      'population_goats': populationGoats,
      'goats_herds': goatsHerds,
      'population_sheep': populationSheep,
      'sheep_herds': sheepHerds,
      'vaccination_status': vaccinationStatus,
      'last_vaccination_date': lastVaccinationDate,
      'total_doses_issued': totalDosesIssued,
      'issued_by': issuedBy,
      'total_doses_received': totalDosesReceived,
      'received_by': receivedBy,
      'total_doses_dispensed': totalDosesDispensed,
      'doses_consumed': dosesConsumed,
      'doses_wasted': dosesWasted,
      'doses_returned': dosesReturned,
      'vaccine_balance': vaccineBalance,
      'store_incharge': storeIncharge,
      'farmer_name': farmerName,
      'phone_no': phoneNo,
      'no_of_sheep_vaccinated': noOfSheepVaccinated,
      'no_of_goats_vaccinated': noOfGoatsVaccinated,
      'created_by': createdBy,
    };
  }

  // Create object from JSON
  factory VaccinationData.fromJson(Map<String, dynamic> json) {
    return VaccinationData(
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      province: json['province'] ?? '',
      district: json['district'] ?? '',
      tehsil: json['tehsil'] ?? '',
      village: json['village'] ?? '',
      vaccinatorName: json['vaccinator_name'] ?? '',
      designation: json['designation'] ?? '',
      hospital: json['hospital'] ?? '',
      populationGoats: json['population_goats'] ?? '',
      goatsHerds: json['goats_herds'] ?? '',
      populationSheep: json['population_sheep'] ?? '',
      sheepHerds: json['sheep_herds'] ?? '',
      vaccinationStatus: json['vaccination_status'] ?? '',
      lastVaccinationDate: json['last_vaccination_date'] ?? '',
      totalDosesIssued: json['total_doses_issued'] ?? '',
      issuedBy: json['issued_by'] ?? '',
      totalDosesReceived: json['total_doses_received'] ?? '',
      receivedBy: json['received_by'] ?? '',
      totalDosesDispensed: json['total_doses_dispensed'] ?? '',
      dosesConsumed: json['doses_consumed'] ?? '',
      dosesWasted: json['doses_wasted'] ?? '',
      dosesReturned: json['doses_returned'] ?? '',
      vaccineBalance: json['vaccine_balance'] ?? '',
      storeIncharge: json['store_incharge'] ?? '',
      farmerName: json['farmer_name'] ?? '',
      phoneNo: json['phone_no'] ?? '',
      noOfSheepVaccinated: json['no_of_sheep_vaccinated'] ?? '',
      noOfGoatsVaccinated: json['no_of_goats_vaccinated'] ?? '',
      createdBy: json['created_by'] ?? '',
    );
  }
}
