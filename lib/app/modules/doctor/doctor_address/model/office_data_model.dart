class OfficeTypeDatum {
  OfficeTypeDatum({
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

  factory OfficeTypeDatum.fromJson(Map<String, dynamic> json) {
    return OfficeTypeDatum(
      id: json["_id"],
      typeOfOfficeKu: json["typeOfOffice_ku"],
      typeOfOfficeAr: json["typeOfOffice_ar"],
      typeOfOfficeEn: json["typeOfOffice_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "typeOfOffice_ku": typeOfOfficeKu,
        "typeOfOffice_ar": typeOfOfficeAr,
        "typeOfOffice_en": typeOfOfficeEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
