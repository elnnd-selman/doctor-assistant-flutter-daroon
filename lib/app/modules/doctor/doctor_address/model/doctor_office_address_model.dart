class DoctorOfficeAddressModel {
  DoctorOfficeAddressModel({
    required this.message,
    required this.success,
    required this.data,
  });

  final String? message;
  final bool? success;
  final List<OfficeAddreesModel> data;

  factory DoctorOfficeAddressModel.fromJson(Map<String, dynamic> json) {
    return DoctorOfficeAddressModel(
      message: json["message"],
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<OfficeAddreesModel>.from(
              json["data"]!.map((x) => OfficeAddreesModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data.map((x) => x.toJson()).toList(),
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
    required this.typeOfOffice,
    required this.daysOpen,
    required this.startTime,
    required this.endTime,
    required this.appointmentDuration,
    required this.appointmentTimeType,
    required this.typeOfCurrency,
    required this.phoneNumbers,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Fee? fee;
  final Address? address;
  final String? id;
  final String? doctor;
  final String? title;
  final String? description;
  final String? typeOfOffice;
  final List<String> daysOpen;
  final String? startTime;
  final String? endTime;
  final int? appointmentDuration;
  final String? appointmentTimeType;
  final String? typeOfCurrency;
  final List<String> phoneNumbers;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory OfficeAddreesModel.fromJson(Map<String, dynamic> json) {
    return OfficeAddreesModel(
      fee: json["fee"] == null ? null : Fee.fromJson(json["fee"]),
      address:
          json["address"] == null ? null : Address.fromJson(json["address"]),
      id: json["_id"],
      doctor: json["doctor"],
      title: json["title"],
      description: json["description"],
      typeOfOffice: json["typeOfOffice"],
      daysOpen: json["daysOpen"] == null
          ? []
          : List<String>.from(json["daysOpen"]!.map((x) => x)),
      startTime: json["startTime"],
      endTime: json["endTime"],
      appointmentDuration: json["appointmentDuration"],
      appointmentTimeType: json["appointmentTimeType"],
      typeOfCurrency: json["typeOfCurrency"],
      phoneNumbers: json["phoneNumbers"] == null
          ? []
          : List<String>.from(json["phoneNumbers"]!.map((x) => x)),
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fee": fee?.toJson(),
        "address": address?.toJson(),
        "_id": id,
        "doctor": doctor,
        "title": title,
        "description": description,
        "typeOfOffice": typeOfOffice,
        "daysOpen": daysOpen.map((x) => x).toList(),
        "startTime": startTime,
        "endTime": endTime,
        "appointmentDuration": appointmentDuration,
        "appointmentTimeType": appointmentTimeType,
        "typeOfCurrency": typeOfCurrency,
        "phoneNumbers": phoneNumbers.map((x) => x).toList(),
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Address {
  Address({
    required this.coordinate,
  });

  final Coordinate? coordinate;

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinate: json["coordinate"] == null
          ? null
          : Coordinate.fromJson(json["coordinate"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "coordinate": coordinate?.toJson(),
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
