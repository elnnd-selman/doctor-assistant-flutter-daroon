class AssistantModel {
  AssistantModel({
    required this.assistants,
    required this.success,
    required this.status,
    required this.data,
  });

  final List<AssistantElement> assistants;
  final bool? success;
  final int? status;
  final Data? data;

  factory AssistantModel.fromJson(Map<String, dynamic> json) {
    return AssistantModel(
      assistants: json["assistants"] == null
          ? []
          : List<AssistantElement>.from(
              json["assistants"]!.map((x) => AssistantElement.fromJson(x))),
      success: json["success"],
      status: json["status"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "assistants": assistants.map((x) => x.toJson()).toList(),
        "success": success,
        "status": status,
        "data": data?.toJson(),
      };
}

class AssistantElement {
  AssistantElement({
    required this.id,
    required this.doctor,
    required this.assistant,
    required this.office,
    required this.disable,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final Doctor? doctor;
  final AssistantAssistant? assistant;
  final Office? office;
  final bool? disable;
  final List<String> permissions;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory AssistantElement.fromJson(Map<String, dynamic> json) {
    return AssistantElement(
      id: json["_id"],
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      assistant: json["assistant"] == null
          ? null
          : AssistantAssistant.fromJson(json["assistant"]),
      office: json["office"] == null ? null : Office.fromJson(json["office"]),
      disable: json["disable"],
      permissions: json["permissions"] == null
          ? []
          : List<String>.from(json["permissions"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "doctor": doctor?.toJson(),
        "assistant": assistant?.toJson(),
        "office": office?.toJson(),
        "disable": disable,
        "permissions": permissions.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class AssistantAssistant {
  AssistantAssistant({
    required this.id,
    required this.name,
    required this.username,
    required this.fullName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.profilePicture,
    required this.dateOfBirth,
  });

  final String? id;
  final String? name;
  final String? username;
  final String? fullName;
  final String? email;
  final String? gender;
  final Phone? phone;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final ProfilePicture? profilePicture;
  final DateTime? dateOfBirth;

  factory AssistantAssistant.fromJson(Map<String, dynamic> json) {
    return AssistantAssistant(
      id: json["_id"],
      name: json["name"],
      username: json["username"],
      fullName: json["fullName"],
      email: json["email"],
      gender: json["gender"],
      phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      profilePicture: json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]),
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "fullName": fullName,
        "email": email,
        "gender": gender,
        "phone": phone?.toJson(),
        "lastName_ku": lastNameKu,
        "lastName_ar": lastNameAr,
        "lastName_en": lastNameEn,
        "profilePicture": profilePicture?.toJson(),
        "dateOfBirth": dateOfBirth?.toIso8601String(),
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

class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.fullName,
    required this.email,
    required this.phone,
  });

  final String? id;
  final String? name;
  final String? fullName;
  final String? email;
  final Phone? phone;

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["_id"],
      name: json["name"],
      fullName: json["fullName"],
      email: json["email"],
      phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "fullName": fullName,
        "email": email,
        "phone": phone?.toJson(),
      };
}

class Office {
  Office({
    required this.id,
    required this.title,
    required this.description,
    required this.typeOfOffice,
    required this.daysOpen,
    required this.startTime,
    required this.endTime,
  });

  final String? id;
  final String? title;
  final String? description;
  final String? typeOfOffice;
  final List<String> daysOpen;
  final String? startTime;
  final String? endTime;

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      id: json["_id"],
      title: json["title"],
      description: json["description"],
      typeOfOffice: json["typeOfOffice"],
      daysOpen: json["daysOpen"] == null
          ? []
          : List<String>.from(json["daysOpen"]!.map((x) => x)),
      startTime: json["startTime"],
      endTime: json["endTime"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "typeOfOffice": typeOfOffice,
        "daysOpen": daysOpen.map((x) => x).toList(),
        "startTime": startTime,
        "endTime": endTime,
      };
}

class Data {
  Data({required this.json});
  final Map<String, dynamic> json;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(json: json);
  }

  Map<String, dynamic> toJson() => {};
}
