class AppointmentModel {
  AppointmentModel({
    required this.id,
    required this.office,
    required this.doctor,
    required this.selectedDay,
    required this.selectedTime,
    required this.isPaid,
    required this.amountPaid,
    required this.currencyPaid,
    required this.fullName,
    required this.age,
    required this.gender,
    required this.extraInformation,
    required this.appointmentDate,
    required this.dateOfBirth,
    required this.appointmentType,
    required this.selfBooked,
    required this.bookedFor,
    required this.bookedBy,
    required this.status,
    required this.cancelledReason,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Office? office;
  final BookedBy? doctor;
  final String? selectedDay;
  final String? selectedTime;
  final bool? isPaid;
  final int? amountPaid;
  final String? currencyPaid;
  final String? fullName;
  final int? age;
  final String? gender;
  final String? extraInformation;
  final DateTime? appointmentDate;
  final DateTime? dateOfBirth;
  final List<String> appointmentType;
  final bool? selfBooked;
  final String? bookedFor;
  final BookedBy? bookedBy;
  final String? status;
  final String? cancelledReason;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json["_id"],
      office: json["office"] == null ? null : Office.fromJson(json["office"]),
      doctor: json["doctor"] == null ? null : BookedBy.fromJson(json["doctor"]),
      selectedDay: json["selectedDay"],
      selectedTime: json["selectedTime"],
      isPaid: json["isPaid"],
      amountPaid: json["amountPaid"],
      currencyPaid: json["currencyPaid"],
      fullName: json["fullName"],
      age: json["age"],
      gender: json["gender"],
      extraInformation: json["extraInformation"],
      appointmentDate: DateTime.tryParse(json["appointmentDate"] ?? ""),
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      appointmentType: json["appointmentType"] == null
          ? []
          : List<String>.from(json["appointmentType"]!.map((x) => x)),
      selfBooked: json["selfBooked"],
      bookedFor: json["bookedFor"],
      bookedBy:
          json["bookedBy"] == null ? null : BookedBy.fromJson(json["bookedBy"]),
      status: json["status"],
      cancelledReason: json["cancelledReason"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class BookedBy {
  BookedBy({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.username,
    required this.education,
    required this.profilePicture,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? username;
  final List<dynamic> education;
  final ProfilePicture? profilePicture;

  factory BookedBy.fromJson(Map<String, dynamic> json) {
    return BookedBy(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      username: json["username"],
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      profilePicture: json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]),
    );
  }
}

class ProfilePicture {
  ProfilePicture({
    required this.bg,
    required this.md,
    required this.sm,
  });

  final String? bg;
  final String? md;
  final String? sm;

  factory ProfilePicture.fromJson(Map<String, dynamic> json) {
    return ProfilePicture(
      bg: json["bg"],
      md: json["md"],
      sm: json["sm"],
    );
  }
}

class Office {
  Office({
    required this.id,
    required this.doctor,
    required this.title,
    required this.description,
    required this.typeOfCurrency,
    required this.address,
    required this.appointmentTimes,
  });

  final String? id;
  final Doctor? doctor;
  final String? title;
  final String? description;
  final TypeOfCurrency? typeOfCurrency;
  final Address? address;
  final AppointmentTimes? appointmentTimes;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["_id"],
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      title: json["title"],
      description: json["description"],
      typeOfCurrency: json["typeOfCurrency"] == null
          ? null
          : TypeOfCurrency.fromJson(json["typeOfCurrency"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      appointmentTimes: json["appointmentTimes"] == null
          ? null
          : AppointmentTimes.fromJson(json["appointmentTimes"]),
    );
  }
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
  final Country? country;
  final String? city;
  final String? town;
  final String? street;
  final TypeOfOffice? typeOfOffice;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinate: json["coordinate"] == null
          ? null
          : Coordinate.fromJson(json["coordinate"]),
      country:
          json["country"] == null ? null : Country.fromJson(json["country"]),
      city: json["city"],
      town: json["town"],
      street: json["street"],
      typeOfOffice: json["typeOfOffice"] == null
          ? null
          : TypeOfOffice.fromJson(json["typeOfOffice"]),
    );
  }
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
}

class Country {
  Country({
    required this.id,
    required this.countryKu,
    required this.countryAr,
    required this.countryEn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? countryKu;
  final String? countryAr;
  final String? countryEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json["_id"],
      countryKu: json["country_ku"],
      countryAr: json["country_ar"],
      countryEn: json["country_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class TypeOfOffice {
  TypeOfOffice({
    required this.id,
    required this.typeOfOfficeKu,
    required this.typeOfOfficeAr,
    required this.typeOfOfficeEn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? typeOfOfficeKu;
  final String? typeOfOfficeAr;
  final String? typeOfOfficeEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory TypeOfOffice.fromJson(Map<String, dynamic> json) {
    return TypeOfOffice(
      id: json["_id"],
      typeOfOfficeKu: json["typeOfOffice_ku"],
      typeOfOfficeAr: json["typeOfOffice_ar"],
      typeOfOfficeEn: json["typeOfOffice_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class AppointmentTimes {
  AppointmentTimes({
    required this.tuesday,
    required this.thursday,
    required this.friday,
    required this.wednesday,
    required this.monday,
    required this.sunday,
    required this.saturday,
  });

  final List<Day> tuesday;
  final List<Day> thursday;
  final List<Day> friday;
  final List<Day> wednesday;
  final List<Day> monday;
  final List<Day> sunday;
  final List<Day> saturday;

  factory AppointmentTimes.fromJson(Map<String, dynamic> json) {
    return AppointmentTimes(
      tuesday: json["tuesday"] == null
          ? []
          : List<Day>.from(json["tuesday"]!.map((x) => Day.fromJson(x))),
      thursday: json["thursday"] == null
          ? []
          : List<Day>.from(json["thursday"]!.map((x) => Day.fromJson(x))),
      friday: json["friday"] == null
          ? []
          : List<Day>.from(json["friday"]!.map((x) => Day.fromJson(x))),
      wednesday: json["wednesday"] == null
          ? []
          : List<Day>.from(json["wednesday"]!.map((x) => Day.fromJson(x))),
      monday: json["monday"] == null
          ? []
          : List<Day>.from(json["monday"]!.map((x) => Day.fromJson(x))),
      sunday: json["sunday"] == null
          ? []
          : List<Day>.from(json["sunday"]!.map((x) => Day.fromJson(x))),
      saturday: json["saturday"] == null
          ? []
          : List<Day>.from(json["saturday"]!.map((x) => Day.fromJson(x))),
    );
  }
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
}

class Doctor {
  Doctor({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    required this.gender,
    required this.password,
    required this.isActive,
    required this.phone,
    required this.education,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.experienceByYear,
    required this.typeOfUser,
    required this.languages,
    required this.appLang,
    required this.backgroundPicture,
    required this.profilePicture,
    required this.isThirdParty,
    required this.usePictureAsLink,
    required this.dateOfBirth,
    required this.isVip,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sessionToken,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? username;
  final String? email;
  final bool? isEmailVerified;
  final String? gender;
  final String? password;
  final bool? isActive;
  final Phone? phone;
  final List<dynamic> education;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final int? experienceByYear;
  final String? typeOfUser;
  final List<String> languages;
  final String? appLang;
  final dynamic backgroundPicture;
  final String? profilePicture;
  final bool? isThirdParty;
  final bool? usePictureAsLink;
  final DateTime? dateOfBirth;
  final bool? isVip;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? sessionToken;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      username: json["username"],
      email: json["email"],
      isEmailVerified: json["isEmailVerified"],
      gender: json["gender"],
      password: json["password"],
      isActive: json["isActive"],
      phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      experienceByYear: json["experienceByYear"],
      typeOfUser: json["typeOfUser"],
      languages: json["languages"] == null
          ? []
          : List<String>.from(json["languages"]!.map((x) => x)),
      appLang: json["appLang"],
      backgroundPicture: json["background_picture"],
      profilePicture: json["profilePicture"],
      isThirdParty: json["isThirdParty"],
      usePictureAsLink: json["usePictureAsLink"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      isVip: json["is_vip"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      sessionToken: json["sessionToken"],
    );
  }
}

class Phone {
  Phone({
    required this.number,
    required this.isVerified,
  });

  final String? number;
  final bool? isVerified;

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      number: json["number"],
      isVerified: json["isVerified"],
    );
  }
}

class TypeOfCurrency {
  TypeOfCurrency({
    required this.id,
    required this.typeOfCurrencyKu,
    required this.typeOfCurrencyAr,
    required this.typeOfCurrencyEn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? typeOfCurrencyKu;
  final String? typeOfCurrencyAr;
  final String? typeOfCurrencyEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory TypeOfCurrency.fromJson(Map<String, dynamic> json) {
    return TypeOfCurrency(
      id: json["_id"],
      typeOfCurrencyKu: json["typeOfCurrency_ku"],
      typeOfCurrencyAr: json["typeOfCurrency_ar"],
      typeOfCurrencyEn: json["typeOfCurrency_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}
