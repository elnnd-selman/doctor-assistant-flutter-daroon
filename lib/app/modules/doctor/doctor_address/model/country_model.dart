class CountryModel {
  CountryModel({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool? success;
  final String? message;
  final List<CountryData> data;

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CountryData>.from(
              json["data"]!.map((x) => CountryData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class CountryData {
  CountryData({
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

  factory CountryData.fromJson(Map<String, dynamic> json) {
    return CountryData(
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
