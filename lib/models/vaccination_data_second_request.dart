class VaccinationDataSecondRequest {
  String id;
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

  VaccinationDataSecondRequest({
    this.id = '',
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

  Map<String, String> toMap() {
    return {
      'id': id,
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
}

class SaveVaccinationDataSheep {
  String id;
  String specie;
  String vaccineType;
  String sheepZeroToThree;
  String sheepFourToTwelve;
  String sheepFourToTwelveVaccinated;
  String sheepThirteenToTwentyFour;
  String sheepThirteenToTwentyFourVaccinated;
  String sheepTwentyFourPlus;
  String sheepTwentyFourPlusVaccinated;
  String createdBy;

  SaveVaccinationDataSheep({
    this.id = '',
    this.specie = '',
    this.vaccineType = '',
    this.sheepZeroToThree = '',
    this.sheepFourToTwelve = '',
    this.sheepFourToTwelveVaccinated = '',
    this.sheepThirteenToTwentyFour = '',
    this.sheepThirteenToTwentyFourVaccinated = '',
    this.sheepTwentyFourPlus = '',
    this.sheepTwentyFourPlusVaccinated = '',
    this.createdBy = '',
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'specie': specie,
      'vaccine_type': vaccineType,
      'sheep_zero_to_three': sheepZeroToThree,
      'sheep_four_to_twelve': sheepFourToTwelve,
      'sheep_four_to_twelve_vaccinated': sheepFourToTwelveVaccinated,
      'sheep_thirteen_to_twentyfour': sheepThirteenToTwentyFour,
      'sheep_thirteen_to_twentyfour_vaccinated':
          sheepThirteenToTwentyFourVaccinated,
      'sheep_twentyfour_plus': sheepTwentyFourPlus,
      'sheep_twentyfour_plus_vaccinated': sheepTwentyFourPlusVaccinated,
      'created_by': createdBy,
    };
  }
}

class SaveVaccinationDataGoat {
  String id;
  String specie;
  String vaccineType;
  String sheepZeroToThree;
  String sheepFourToTwelve;
  String sheepFourToTwelveVaccinated;
  String sheepThirteenToTwentyFour;
  String sheepThirteenToTwentyFourVaccinated;
  String sheepTwentyFourPlus;
  String sheepTwentyFourPlusVaccinated;
  String createdBy;

  SaveVaccinationDataGoat({
    this.id = '',
    this.specie = '',
    this.vaccineType = '',
    this.sheepZeroToThree = '',
    this.sheepFourToTwelve = '',
    this.sheepFourToTwelveVaccinated = '',
    this.sheepThirteenToTwentyFour = '',
    this.sheepThirteenToTwentyFourVaccinated = '',
    this.sheepTwentyFourPlus = '',
    this.sheepTwentyFourPlusVaccinated = '',
    this.createdBy = '',
  });

  Map<String, String> toMap() {
    return {
      'id': id,
      'specie': specie,
      'vaccine_type': vaccineType,
      'sheep_zero_to_three': sheepZeroToThree,
      'sheep_four_to_twelve': sheepFourToTwelve,
      'sheep_four_to_twelve_vaccinated': sheepFourToTwelveVaccinated,
      'sheep_thirteen_to_twentyfour': sheepThirteenToTwentyFour,
      'sheep_thirteen_to_twentyfour_vaccinated':
          sheepThirteenToTwentyFourVaccinated,
      'sheep_twentyfour_plus': sheepTwentyFourPlus,
      'sheep_twentyfour_plus_vaccinated': sheepTwentyFourPlusVaccinated,
      'created_by': createdBy,
    };
  }
}
