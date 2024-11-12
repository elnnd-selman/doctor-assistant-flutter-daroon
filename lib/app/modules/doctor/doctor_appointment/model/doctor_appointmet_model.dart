class DoctorAppointmentModel {
  DoctorAppointmentModel({
    required this.success,
    required this.data,
    required this.message,
    required this.status,
  });

  final bool? success;
  final List<AppointmentModel> data;
  final String? message;
  final int? status;

  factory DoctorAppointmentModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointmentModel(
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<AppointmentModel>.from(
              json["data"]!.map((x) => AppointmentModel.fromJson(x))),
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.map((x) => x.toJson()).toList(),
        "message": message,
        "status": status,
      };
}

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
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.cancelledReason,
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
  final bool? isDeleted;
  final DateTime? createdAt;
  String cancelledReason;
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
      cancelledReason:
          json['cancelledReason'] == null ? '' : json["cancelledReason"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "office": office?.toJson(),
        "doctor": doctor?.toJson(),
        "selectedDay": selectedDay,
        "selectedTime": selectedTime,
        "isPaid": isPaid,
        "amountPaid": amountPaid,
        "currencyPaid": currencyPaid,
        "fullName": fullName,
        "age": age,
        "gender": gender,
        "extraInformation": extraInformation,
        "appointmentDate": appointmentDate?.toIso8601String(),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "appointmentType": appointmentType.map((x) => x).toList(),
        "selfBooked": selfBooked,
        "bookedFor": bookedFor,
        "bookedBy": bookedBy?.toJson(),
        "status": status,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class BookedBy {
  BookedBy({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.education,
    required this.profilePicture,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final List<dynamic> education;
  final ProfilePicture? profilePicture;

  factory BookedBy.fromJson(Map<String, dynamic> json) {
    return BookedBy(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      profilePicture: json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "firstName_ku": firstNameKu,
        "firstName_en": firstNameEn,
        "firstName_ar": firstNameAr,
        "education": education.map((x) => x).toList(),
        "profilePicture": profilePicture?.toJson(),
      };
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
    required this.address,
  });

  final String? id;
  final String? title;
  final String? description;
  final Address? address;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "address": address?.toJson(),
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
