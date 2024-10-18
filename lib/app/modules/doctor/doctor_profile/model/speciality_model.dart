class SpecialityModel {
  SpecialityModel({
    required this.data,
    required this.success,
    required this.status,
  });

  final List<SpecialityData> data;
  final bool? success;
  final int? status;

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    return SpecialityModel(
      data: json["data"] == null
          ? []
          : List<SpecialityData>.from(
              json["data"]!.map((x) => SpecialityData.fromJson(x))),
      success: json["success"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "success": success,
        "status": status,
      };
}

class SpecialityData {
  SpecialityData({
    required this.id,
    required this.specialityKu,
    required this.specialityAr,
    required this.specialityEn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? specialityKu;
  final String? specialityAr;
  final String? specialityEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory SpecialityData.fromJson(Map<String, dynamic> json) {
    return SpecialityData(
      id: json["_id"],
      specialityKu: json["speciality_ku"],
      specialityAr: json["speciality_ar"],
      specialityEn: json["speciality_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "speciality_ku": specialityKu,
        "speciality_ar": specialityAr,
        "speciality_en": specialityEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
