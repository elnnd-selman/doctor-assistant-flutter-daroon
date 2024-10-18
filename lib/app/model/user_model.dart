import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  UserModel({
    required this.user,
    required this.token,
    required this.success,
    required this.message,
    required this.status,
  });
  @HiveField(0)
  final User? user;
  @HiveField(1)
  final String? token;
  @HiveField(2)
  final bool? success;
  @HiveField(3)
  final String? message;
  @HiveField(4)
  final int? status;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      token: json["token"],
      success: json["success"],
      message: json["message"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "success": success,
        "message": message,
        "status": status,
      };
}

@HiveType(typeId: 2)
class User {
  User({
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
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? firstName;
  @HiveField(2)
  final String? firstNameKu;
  @HiveField(3)
  final String? firstNameEn;
  @HiveField(4)
  final String? firstNameAr;
  @HiveField(5)
  final String? username;
  @HiveField(6)
  final String? email;
  @HiveField(7)
  final bool? isEmailVerified;
  @HiveField(8)
  final String? gender;
  @HiveField(9)
  final String? biographyKu;
  @HiveField(10)
  final String? biographyAr;
  @HiveField(11)
  final String? biographyEn;
  @HiveField(12)
  final bool? isActive;
  @HiveField(13)
  final Phone? phone;
  @HiveField(14)
  final String? level;
  @HiveField(15)
  final String? speciality;
  @HiveField(16)
  final List<String> education;
  @HiveField(17)
  final String? lastNameKu;
  @HiveField(18)
  final String? lastNameAr;
  @HiveField(19)
  final String? lastNameEn;
  @HiveField(20)
  final int? experienceByYear;
  @HiveField(21)
  final String? typeOfUser;
  @HiveField(22)
  final List<String> languages;
  @HiveField(23)
  final String? appLang;
  @HiveField(24)
  final bool? isThirdParty;
  @HiveField(25)
  final bool? usePictureAsLink;
  @HiveField(26)
  final DateTime? dateOfBirth;
  @HiveField(27)
  final DateTime? createdAt;
  @HiveField(28)
  final DateTime? updatedAt;
  @HiveField(29)
  final int? v;
  @HiveField(30)
  final String? sessionToken;
  @HiveField(31)
  final dynamic profilePicture;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      level: json["level"],
      speciality: json["speciality"],
      education: json["education"] == null
          ? []
          : List<String>.from(json["education"]!.map((x) => x)),
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
      profilePicture: json["profilePicture"],
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
        "level": level,
        "speciality": speciality,
        "education": education.map((x) => x).toList(),
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
        "profilePicture": profilePicture,
      };
}

@HiveType(typeId: 3)
class Phone {
  Phone({
    required this.number,
    required this.isVerified,
  });
  @HiveField(0)
  final String? number;
  @HiveField(1)
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
