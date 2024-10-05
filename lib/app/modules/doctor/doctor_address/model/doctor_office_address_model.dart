class DoctorOfficeAddressModel {
  DoctorOfficeAddressModel({
    required this.message,
    required this.success,
    required this.data,
    required this.status,
  });

  final String? message;
  final bool? success;
  final List<OfficeAddreesModel> data;
  final int? status;

  factory DoctorOfficeAddressModel.fromJson(Map<String, dynamic> json) {
    return DoctorOfficeAddressModel(
      message: json["message"],
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<OfficeAddreesModel>.from(
              json["data"]!.map((x) => OfficeAddreesModel.fromJson(x))),
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data.map((x) => x.toJson()).toList(),
        "status": status,
      };
}

class OfficeAddreesModel {
  OfficeAddreesModel({
    required this.fee,
    required this.address,
    required this.id,
    required this.doctor,
    required this.title,
    required this.description,
    required this.daysOpen,
    required this.startTime,
    required this.endTime,
    required this.appointmentDuration,
    required this.appointmentTimeType,
    required this.typeOfCurrency,
    required this.phoneNumbers,
    required this.isDeleted,
    required this.appointmentTimes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.buildingNumber,
    required this.floor,
    required this.room,
  });

  final Fee? fee;
  final Address? address;
  final String? id;
  final String? doctor;
  final String? title;
  final String? description;
  final List<String> daysOpen;
  final String? startTime;
  final String? endTime;
  final int? appointmentDuration;
  final String? appointmentTimeType;
  final TypeOfCurrency? typeOfCurrency;
  final List<String> phoneNumbers;
  final bool? isDeleted;
  final AppointmentTimes? appointmentTimes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? buildingNumber;
  final int? floor;
  final int? room;

  factory OfficeAddreesModel.fromJson(Map<String, dynamic> json) {
    return OfficeAddreesModel(
      fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      id: json["_id"],
      doctor: json["doctor"],
      title: json["title"],
      description: json["description"],
      daysOpen: json["daysOpen"] == null
          ? []
          : List<String>.from(json["daysOpen"]!.map((x) => x)),
      startTime: json["startTime"],
      endTime: json["endTime"],
      appointmentDuration: json["appointmentDuration"],
      appointmentTimeType: json["appointmentTimeType"],
      typeOfCurrency: json["typeOfCurrency"] == null
          ? null
          : TypeOfCurrency.fromJson(json["typeOfCurrency"]),
      phoneNumbers: json["phoneNumbers"] == null
          ? []
          : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
      isDeleted: json["isDeleted"],
      appointmentTimes: json["appointmentTimes"] == null
          ? null
          : AppointmentTimes.fromJson(json["appointmentTimes"]),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      buildingNumber: json["buildingNumber"],
      floor: json["floor"],
      room: json["room"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fee": fee?.toJson(),
        "address": address?.toJson(),
        "_id": id,
        "doctor": doctor,
        "title": title,
        "description": description,
        "daysOpen": daysOpen.map((x) => x).toList(),
        "startTime": startTime,
        "endTime": endTime,
        "appointmentDuration": appointmentDuration,
        "appointmentTimeType": appointmentTimeType,
        "typeOfCurrency": typeOfCurrency?.toJson(),
        "phoneNumbers": phoneNumbers.map((x) => x).toList(),
        "isDeleted": isDeleted,
        "appointmentTimes": appointmentTimes?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "buildingNumber": buildingNumber,
        "floor": floor,
        "room": room,
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
  final Country? country;
  final String? city;
  final String? town;
  final String? street;
  final dynamic typeOfOffice;

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
      typeOfOffice: json["typeOfOffice"],
    );
  }

  Map<String, dynamic> toJson() => {
        "coordinate": coordinate?.toJson(),
        "country": country?.toJson(),
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "country_ku": countryKu,
        "country_ar": countryAr,
        "country_en": countryEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "typeOfCurrency_ku": typeOfCurrencyKu,
        "typeOfCurrency_ar": typeOfCurrencyAr,
        "typeOfCurrency_en": typeOfCurrencyEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
