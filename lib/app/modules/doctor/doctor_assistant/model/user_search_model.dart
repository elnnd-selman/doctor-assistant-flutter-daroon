class UserSearchModel {
  UserSearchModel({
    required this.data,
    required this.currentPage,
    required this.totalRecord,
    required this.success,
    required this.status,
  });

  final List<UserSearchDataModel> data;
  final int? currentPage;
  final int? totalRecord;
  final bool? success;
  final int? status;

  factory UserSearchModel.fromJson(Map<String, dynamic> json) {
    return UserSearchModel(
      data: json["data"] == null
          ? []
          : List<UserSearchDataModel>.from(
              json["data"]!.map((x) => UserSearchDataModel.fromJson(x))),
      currentPage: json["currentPage"],
      totalRecord: json["totalRecord"],
      success: json["success"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "currentPage": currentPage,
        "totalRecord": totalRecord,
        "success": success,
        "status": status,
      };
}

class UserSearchDataModel {
  UserSearchDataModel({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.gender,
    required this.isActive,
    required this.education,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.languages,
    required this.profilePicture,
    required this.dateOfBirth,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? gender;
  final bool? isActive;
  final List<dynamic> education;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final List<dynamic> languages;
  final ProfilePicture? profilePicture;
  final DateTime? dateOfBirth;

  factory UserSearchDataModel.fromJson(Map<String, dynamic> json) {
    return UserSearchDataModel(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      gender: json["gender"],
      isActive: json["isActive"],
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      languages: json["languages"] == null
          ? []
          : List<dynamic>.from(json["languages"]!.map((x) => x)),
      profilePicture: json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]),
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "firstName_ku": firstNameKu,
        "firstName_en": firstNameEn,
        "firstName_ar": firstNameAr,
        "gender": gender,
        "isActive": isActive,
        "education": education.map((x) => x).toList(),
        "lastName_ku": lastNameKu,
        "lastName_ar": lastNameAr,
        "lastName_en": lastNameEn,
        "languages": languages.map((x) => x).toList(),
        "profilePicture": profilePicture?.toJson(),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
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
