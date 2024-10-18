class LevelModel {
  LevelModel({
    required this.data,
    required this.success,
    required this.status,
  });

  final List<LevelData> data;
  final bool? success;
  final int? status;

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      data: json["data"] == null
          ? []
          : List<LevelData>.from(
              json["data"]!.map((x) => LevelData.fromJson(x))),
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

class LevelData {
  LevelData({
    required this.id,
    required this.levelKu,
    required this.levelAr,
    required this.levelEn,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? levelKu;
  final String? levelAr;
  final String? levelEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory LevelData.fromJson(Map<String, dynamic> json) {
    return LevelData(
      id: json["_id"],
      levelKu: json["level_ku"],
      levelAr: json["level_ar"],
      levelEn: json["level_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "level_ku": levelKu,
        "level_ar": levelAr,
        "level_en": levelEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
