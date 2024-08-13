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
    required this.transaction,
    required this.appointmentDate,
    required this.appointmentType,
    required this.selfBooked,
    required this.bookedBy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Office? office;
  final Doctor? doctor;
  final String? selectedDay;
  final String? selectedTime;
  final bool? isPaid;
  final int? amountPaid;
  final String? currencyPaid;
  final String? fullName;
  final int? age;
  final String? gender;
  final dynamic transaction;
  final DateTime? appointmentDate;
  final List<String> appointmentType;
  final bool? selfBooked;
  final String? bookedBy;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json["_id"],
      office: json["office"] == null ? null : Office.fromJson(json["office"]),
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      selectedDay: json["selectedDay"],
      selectedTime: json["selectedTime"],
      isPaid: json["isPaid"],
      amountPaid: json["amountPaid"],
      currencyPaid: json["currencyPaid"],
      fullName: json["fullName"],
      age: json["age"],
      gender: json["gender"],
      transaction: json["transaction"],
      appointmentDate: DateTime.tryParse(json["appointmentDate"] ?? ""),
      appointmentType: json["appointmentType"] == null
          ? []
          : List<String>.from(json["appointmentType"]!.map((x) => x)),
      selfBooked: json["selfBooked"],
      bookedBy: json["bookedBy"],
      status: json["status"],
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
        "transaction": transaction,
        "appointmentDate": appointmentDate?.toIso8601String(),
        "appointmentType": appointmentType.map((x) => x).toList(),
        "selfBooked": selfBooked,
        "bookedBy": bookedBy,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.nameKu,
    required this.nameEn,
    required this.nameAr,
    required this.fullName,
    required this.fullNameKu,
    required this.fullNameAr,
    required this.fullNameEn,
  });

  final String? id;
  final String? name;
  final String? nameKu;
  final String? nameEn;
  final String? nameAr;
  final String? fullName;
  final String? fullNameKu;
  final String? fullNameAr;
  final String? fullNameEn;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["_id"],
      name: json["name"],
      nameKu: json["name_ku"],
      nameEn: json["name_en"],
      nameAr: json["name_ar"],
      fullName: json["fullName"],
      fullNameKu: json["fullName_ku"],
      fullNameAr: json["fullName_ar"],
      fullNameEn: json["fullName_en"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "name_ku": nameKu,
        "name_en": nameEn,
        "name_ar": nameAr,
        "fullName": fullName,
        "fullName_ku": fullNameKu,
        "fullName_ar": fullNameAr,
        "fullName_en": fullNameEn,
      };
}

class Office {
  Office({
    required this.id,
    required this.title,
  });

  final String? id;
  final String? title;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["_id"],
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
      };
}
