class UserProfileModel {
  UserProfileModel({
    required this.userProfile,
    required this.success,
    required this.message,
    required this.status,
  });

  final UserProfileData? userProfile;
  final bool? success;
  final String? message;
  final int? status;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userProfile:
          json["user"] == null ? null : UserProfileData.fromJson(json["user"]),
      success: json["success"],
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": userProfile?.toJson(),
        "success": success,
        "message": message,
        "status": status,
      };
}

class UserProfileData {
  UserProfileData({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    required this.gender,
    required this.biographyKu,
    required this.biographyAr,
    required this.biographyEn,
    required this.isActive,
    required this.phone,
    required this.level,
    required this.speciality,
    required this.education,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.experienceByYear,
    required this.typeOfUser,
    required this.languages,
    required this.appLang,
    required this.isThirdParty,
    required this.usePictureAsLink,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sessionToken,
    required this.profilePicture,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? username;
  final String? email;
  final bool? isEmailVerified;
  String? gender;
  final String? biographyKu;
  final String? biographyAr;
  final String? biographyEn;
  final bool? isActive;
  final Phone? phone;
  final Level? level;
  final Speciality? speciality;
  final List<Education> education;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final int? experienceByYear;
  final String? typeOfUser;
  final List<String> languages;
  final String? appLang;
  final bool? isThirdParty;
  final bool? usePictureAsLink;
  final DateTime? dateOfBirth;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? sessionToken;
  final ProfilePicture? profilePicture;

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      username: json["username"],
      email: json["email"],
      isEmailVerified: json["isEmailVerified"],
      gender: json["gender"],
      biographyKu: json["biography_ku"],
      biographyAr: json["biography_ar"],
      biographyEn: json["biography_en"],
      isActive: json["isActive"],
      phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
      level: json["level"] == null ? null : Level.fromJson(json["level"]),
      speciality: json["speciality"] == null
          ? null
          : Speciality.fromJson(json["speciality"]),
      education: json["education"] == null
          ? []
          : List<Education>.from(
              json["education"]!.map((x) => Education.fromJson(x))),
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      experienceByYear: json["experienceByYear"],
      typeOfUser: json["typeOfUser"],
      languages: json["languages"] == null
          ? []
          : List<String>.from(json["languages"]!.map((x) => x)),
      appLang: json["appLang"],
      isThirdParty: json["isThirdParty"],
      usePictureAsLink: json["usePictureAsLink"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      sessionToken: json["sessionToken"],
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
        "username": username,
        "email": email,
        "isEmailVerified": isEmailVerified,
        "gender": gender,
        "biography_ku": biographyKu,
        "biography_ar": biographyAr,
        "biography_en": biographyEn,
        "isActive": isActive,
        "phone": phone?.toJson(),
        "level": level?.toJson(),
        "speciality": speciality?.toJson(),
        "education": education.map((x) => x.toJson()).toList(),
        "lastName_ku": lastNameKu,
        "lastName_ar": lastNameAr,
        "lastName_en": lastNameEn,
        "experienceByYear": experienceByYear,
        "typeOfUser": typeOfUser,
        "languages": languages.map((x) => x).toList(),
        "appLang": appLang,
        "isThirdParty": isThirdParty,
        "usePictureAsLink": usePictureAsLink,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "sessionToken": sessionToken,
        "profilePicture": profilePicture?.toJson(),
      };
}

class Education {
  Education({
    required this.id,
    required this.degree,
    required this.fromYear,
    required this.toYear,
    required this.instituteAr,
    required this.instituteEn,
    required this.instituteKu,
    required this.degreeNameAr,
    required this.degreeNameEn,
    required this.degreeNameKu,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? degree;
  final String? fromYear;
  final String? toYear;
  final String? instituteAr;
  final String? instituteEn;
  final String? instituteKu;
  final String? degreeNameAr;
  final String? degreeNameEn;
  final String? degreeNameKu;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json["_id"],
      degree: json["degree"],
      fromYear: json["fromYear"],
      toYear: json["toYear"],
      instituteAr: json["institute_ar"],
      instituteEn: json["institute_en"],
      instituteKu: json["institute_ku"],
      degreeNameAr: json["degreeName_ar"],
      degreeNameEn: json["degreeName_en"],
      degreeNameKu: json["degreeName_ku"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "degree": degree,
        "fromYear": fromYear,
        "toYear": toYear,
        "institute_ar": instituteAr,
        "institute_en": instituteEn,
        "institute_ku": instituteKu,
        "degreeName_ar": degreeNameAr,
        "degreeName_en": degreeNameEn,
        "degreeName_ku": degreeNameKu,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Level {
  Level({
    required this.levelKu,
    required this.levelAr,
    required this.levelEn,
  });

  final String? levelKu;
  final String? levelAr;
  final String? levelEn;

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      levelKu: json["level_ku"],
      levelAr: json["level_ar"],
      levelEn: json["level_en"],
    );
  }

  Map<String, dynamic> toJson() => {
        "level_ku": levelKu,
        "level_ar": levelAr,
        "level_en": levelEn,
      };
}

class Phone {
  Phone({
    required this.number,
    required this.isVerified,
  });

  final String? number;
  final bool? isVerified;

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      number: json["number"],
      isVerified: json["isVerified"],
    );
  }

  Map<String, dynamic> toJson() => {
        "number": number,
        "isVerified": isVerified,
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

class Speciality {
  Speciality({
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

  factory Speciality.fromJson(Map<String, dynamic> json) {
    return Speciality(
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
