class DoctorOfferModel {
  DoctorOfferModel({
    required this.message,
    required this.success,
    required this.status,
    required this.data,
  });

  final String? message;
  final bool? success;
  final int? status;
  final List<DoctorOffersData> data;

  factory DoctorOfferModel.fromJson(Map<String, dynamic> json) {
    return DoctorOfferModel(
      message: json["message"],
      success: json["success"],
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<DoctorOffersData>.from(
              json["data"]!.map((x) => DoctorOffersData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class DoctorOffersData {
  DoctorOffersData({
    required this.id,
    required this.doctor,
    required this.titleKu,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionKu,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.discountPercentage,
    required this.status,
    required this.currentPrice,
    required this.currency,
    required this.image,
    required this.office,
    required this.discountedPrice,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Doctor? doctor;
  final String? titleKu;
  final String? titleAr;
  final String? titleEn;
  final String? descriptionKu;
  final String? descriptionAr;
  final String? descriptionEn;
  final int? discountPercentage;
  final String? status;
  final int? currentPrice;
  final String? currency;
  final Image? image;
  final Office? office;
  final int? discountedPrice;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory DoctorOffersData.fromJson(Map<String, dynamic> json) {
    return DoctorOffersData(
      id: json["_id"],
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      titleKu: json["title_ku"],
      titleAr: json["title_ar"],
      titleEn: json["title_en"],
      descriptionKu: json["description_ku"],
      descriptionAr: json["description_ar"],
      descriptionEn: json["description_en"],
      discountPercentage: json["discountPercentage"],
      status: json["status"],
      currentPrice: json["currentPrice"],
      currency: json["currency"],
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      office: json["office"] == null ? null : Office.fromJson(json["office"]),
      discountedPrice: json["discountedPrice"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "doctor": doctor?.toJson(),
        "title_ku": titleKu,
        "title_ar": titleAr,
        "title_en": titleEn,
        "description_ku": descriptionKu,
        "description_ar": descriptionAr,
        "description_en": descriptionEn,
        "discountPercentage": discountPercentage,
        "status": status,
        "currentPrice": currentPrice,
        "currency": currency,
        "image": image?.toJson(),
        "office": office?.toJson(),
        "discountedPrice": discountedPrice,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Doctor {
  Doctor({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.username,
    required this.gender,
    required this.biographyKu,
    required this.biographyAr,
    required this.biographyEn,
    required this.level,
    required this.speciality,
    required this.education,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.experienceByYear,
    required this.typeOfUser,
    required this.languages,
    required this.usePictureAsLink,
    required this.dateOfBirth,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? username;
  final String? gender;
  final String? biographyKu;
  final String? biographyAr;
  final String? biographyEn;
  final String? level;
  final String? speciality;
  final List<String> education;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final int? experienceByYear;
  final String? typeOfUser;
  final List<String> languages;
  final bool? usePictureAsLink;
  final DateTime? dateOfBirth;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      username: json["username"],
      gender: json["gender"],
      biographyKu: json["biography_ku"],
      biographyAr: json["biography_ar"],
      biographyEn: json["biography_en"],
      level: json["level"],
      speciality: json["speciality"],
      education: json["education"] == null
          ? []
          : List<String>.from(json["education"]!.map((x) => x)),
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      experienceByYear: json["experienceByYear"],
      typeOfUser: json["typeOfUser"],
      languages: json["languages"] == null
          ? []
          : List<String>.from(json["languages"]!.map((x) => x)),
      usePictureAsLink: json["usePictureAsLink"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "firstName_ku": firstNameKu,
        "firstName_en": firstNameEn,
        "firstName_ar": firstNameAr,
        "username": username,
        "gender": gender,
        "biography_ku": biographyKu,
        "biography_ar": biographyAr,
        "biography_en": biographyEn,
        "level": level,
        "speciality": speciality,
        "education": education.map((x) => x).toList(),
        "lastName_ku": lastNameKu,
        "lastName_ar": lastNameAr,
        "lastName_en": lastNameEn,
        "experienceByYear": experienceByYear,
        "typeOfUser": typeOfUser,
        "languages": languages.map((x) => x).toList(),
        "usePictureAsLink": usePictureAsLink,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
      };
}

class Image {
  Image({
    required this.bg,
    required this.md,
    required this.sm,
  });

  final String? bg;
  final String? md;
  final String? sm;

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      bg: json["bg"],
      md: json["md"],
      sm: json["sm"],
    );
  }

  Map<String, dynamic> toJson() => {
        "bg": bg,
        "md": md,
        "sm": sm,
      };
}

class Office {
  Office({
    required this.id,
    required this.title,
    required this.description,
    required this.daysOpen,
    required this.startTime,
    required this.endTime,
    required this.appointmentDuration,
    required this.appointmentTimeType,
    required this.fee,
    required this.typeOfCurrency,
    required this.phoneNumbers,
    required this.address,
    required this.appointmentTimes,
  });

  final String? id;
  final String? title;
  final String? description;
  final List<String> daysOpen;
  final String? startTime;
  final String? endTime;
  final int? appointmentDuration;
  final String? appointmentTimeType;
  final Fee? fee;
  final String? typeOfCurrency;
  final List<String> phoneNumbers;
  final Address? address;
  final AppointmentTimes? appointmentTimes;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      daysOpen: json["daysOpen"] == null
          ? []
          : List<String>.from(json["daysOpen"]!.map((x) => x)),
      startTime: json["startTime"],
      endTime: json["endTime"],
      appointmentDuration: json["appointmentDuration"],
      appointmentTimeType: json["appointmentTimeType"],
      fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
      typeOfCurrency: json["typeOfCurrency"],
      phoneNumbers: json["phoneNumbers"] == null
          ? []
          : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      appointmentTimes: json["appointmentTimes"] == null
          ? null
          : AppointmentTimes.fromJson(json["appointmentTimes"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "daysOpen": daysOpen.map((x) => x).toList(),
        "startTime": startTime,
        "endTime": endTime,
        "appointmentDuration": appointmentDuration,
        "appointmentTimeType": appointmentTimeType,
        "fee": fee?.toJson(),
        "typeOfCurrency": typeOfCurrency,
        "phoneNumbers": phoneNumbers.map((x) => x).toList(),
        "address": address?.toJson(),
        "appointmentTimes": appointmentTimes?.toJson(),
      };
}

class Address {
  Address({
    required this.coordinate,
    required this.country,
    required this.city,
    required this.town,
    required this.street,
    required this.typeOfOffice,
  });

  final Coordinate? coordinate;
  final String? country;
  final String? city;
  final String? town;
  final String? street;
  final String? typeOfOffice;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinate: json["coordinate"] == null
          ? null
          : Coordinate.fromJson(json["coordinate"]),
      country: json["country"],
      city: json["city"],
      town: json["town"],
      street: json["street"],
      typeOfOffice: json["typeOfOffice"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coordinate": coordinate?.toJson(),
        "country": country,
        "city": city,
        "town": town,
        "street": street,
        "typeOfOffice": typeOfOffice,
      };
}

class Coordinate {
  Coordinate({
    required this.latitude,
    required this.longitude,
  });

  final double? latitude;
  final double? longitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) {
    return Coordinate(
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class AppointmentTimes {
  AppointmentTimes({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  final List<Day> sunday;
  final List<Day> monday;
  final List<Day> tuesday;
  final List<Day> wednesday;
  final List<Day> thursday;
  final List<Day> friday;
  final List<Day> saturday;

  factory AppointmentTimes.fromJson(Map<String, dynamic> json) {
    return AppointmentTimes(
      sunday: json["sunday"] == null
          ? []
          : List<Day>.from(json["sunday"]!.map((x) => Day.fromJson(x))),
      monday: json["monday"] == null
          ? []
          : List<Day>.from(json["monday"]!.map((x) => Day.fromJson(x))),
      tuesday: json["tuesday"] == null
          ? []
          : List<Day>.from(json["tuesday"]!.map((x) => Day.fromJson(x))),
      wednesday: json["wednesday"] == null
          ? []
          : List<Day>.from(json["wednesday"]!.map((x) => Day.fromJson(x))),
      thursday: json["thursday"] == null
          ? []
          : List<Day>.from(json["thursday"]!.map((x) => Day.fromJson(x))),
      friday: json["friday"] == null
          ? []
          : List<Day>.from(json["friday"]!.map((x) => Day.fromJson(x))),
      saturday: json["saturday"] == null
          ? []
          : List<Day>.from(json["saturday"]!.map((x) => Day.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "sunday": sunday.map((x) => x.toJson()).toList(),
        "monday": monday.map((x) => x.toJson()).toList(),
        "tuesday": tuesday.map((x) => x.toJson()).toList(),
        "wednesday": wednesday.map((x) => x.toJson()).toList(),
        "thursday": thursday.map((x) => x.toJson()).toList(),
        "friday": friday.map((x) => x.toJson()).toList(),
        "saturday": saturday.map((x) => x.toJson()).toList(),
      };
}

class Day {
  Day({
    required this.time,
    required this.isBooked,
  });

  final String? time;
  final bool? isBooked;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      time: json["time"],
      isBooked: json["isBooked"],
    );
  }

  Map<String, dynamic> toJson() => {
        "time": time,
        "isBooked": isBooked,
      };
}

class Fee {
  Fee({
    required this.feeClinic,
    required this.feeMessage,
    required this.feeCall,
    required this.feeVideoCall,
  });

  final int? feeClinic;
  final int? feeMessage;
  final int? feeCall;
  final int? feeVideoCall;

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      feeClinic: json["feeClinic"],
      feeMessage: json["feeMessage"],
      feeCall: json["feeCall"],
      feeVideoCall: json["feeVideoCall"],
    );
  }

  Map<String, dynamic> toJson() => {
        "feeClinic": feeClinic,
        "feeMessage": feeMessage,
        "feeCall": feeCall,
        "feeVideoCall": feeVideoCall,
      };
}
