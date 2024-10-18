class CurrencyModel {
  CurrencyModel({
    required this.success,
    required this.message,
    required this.status,
    required this.data,
  });

  final bool? success;
  final String? message;
  final int? status;
  final List<CurrencyData> data;

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      success: json["success"],
      message: json["message"],
      status: json["status"],
      data: json["data"] == null
          ? []
          : List<CurrencyData>.from(
              json["data"]!.map((x) => CurrencyData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class CurrencyData {
  CurrencyData({
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

  factory CurrencyData.fromJson(Map<String, dynamic> json) {
    return CurrencyData(
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
