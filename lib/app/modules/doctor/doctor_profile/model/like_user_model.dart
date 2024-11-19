class LikeUserModel {
  LikeUserModel({
    required this.message,
    required this.data,
    required this.success,
    required this.status,
  });

  final String? message;
  final List<LikeUserModelData> data;
  final bool? success;
  final int? status;

  factory LikeUserModel.fromJson(Map<String, dynamic> json) {
    return LikeUserModel(
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<LikeUserModelData>.from(
              json["data"]!.map((x) => LikeUserModelData.fromJson(x))),
      success: json["success"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.map((x) => x.toJson()).toList(),
        "success": success,
        "status": status,
      };
}

class LikeUserModelData {
  LikeUserModelData({
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
  final dynamic profilePicture;

  factory LikeUserModelData.fromJson(Map<String, dynamic> json) {
    return LikeUserModelData(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      profilePicture: json["profilePicture"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "firstName_ku": firstNameKu,
        "firstName_en": firstNameEn,
        "firstName_ar": firstNameAr,
        "education": education.map((x) => x).toList(),
        "profilePicture": profilePicture,
      };
}
