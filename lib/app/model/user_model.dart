class UserModel {
  UserModel({
    required this.user,
    required this.token,
    required this.success,
    required this.message,
  });

  final Users? user;
  final String? token;
  final bool? success;
  final String? message;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: json["user"] == null ? null : Users.fromJson(json["user"]),
      token: json["token"],
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "success": success,
        "message": message,
      };
}

class Users {
  Users({
    required this.name,
    required this.username,
    required this.fullName,
    required this.email,
    required this.isEmailVerified,
    required this.isActive,
    required this.gender,
    required this.phone,
    required this.typeOfUser,
    required this.listOfAssistants,
    required this.language,
    required this.id,
    required this.education,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? name;
  final String? username;
  final String? fullName;
  final String? email;
  final bool? isEmailVerified;
  final bool? isActive;
  final String? gender;
  final Phone? phone;
  final String? typeOfUser;
  final List<dynamic> listOfAssistants;
  final String? language;
  final String? id;
  final List<dynamic> education;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json["name"],
      username: json["username"],
      fullName: json["fullName"],
      email: json["email"],
      isEmailVerified: json["isEmailVerified"],
      isActive: json["isActive"],
      gender: json["gender"],
      phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
      typeOfUser: json["typeOfUser"],
      listOfAssistants: json["listOfAssistants"] == null
          ? []
          : List<dynamic>.from(json["listOfAssistants"]!.map((x) => x)),
      language: json["language"],
      id: json["_id"],
      education: json["education"] == null
          ? []
          : List<dynamic>.from(json["education"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "fullName": fullName,
        "email": email,
        "isEmailVerified": isEmailVerified,
        "isActive": isActive,
        "gender": gender,
        "phone": phone?.toJson(),
        "typeOfUser": typeOfUser,
        "listOfAssistants": listOfAssistants.map((x) => x).toList(),
        "language": language,
        "_id": id,
        "education": education.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
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
