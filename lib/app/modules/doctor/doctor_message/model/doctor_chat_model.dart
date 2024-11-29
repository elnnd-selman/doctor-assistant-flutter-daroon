class DoctorChatModel {
  DoctorChatModel({
    required this.id,
    required this.conversation,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? conversation;
  final ErId? senderId;
  final ErId? receiverId;
  final String? text;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory DoctorChatModel.fromJson(Map<String, dynamic> json) {
    return DoctorChatModel(
      id: json["_id"],
      conversation: json["conversation"],
      senderId:
          json["senderId"] == null ? null : ErId.fromJson(json["senderId"]),
      receiverId:
          json["receiverId"] == null ? null : ErId.fromJson(json["receiverId"]),
      text: json["text"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class ErId {
  ErId({
    required this.id,
    required this.firstName,
    required this.firstNameKu,
    required this.firstNameEn,
    required this.firstNameAr,
    required this.username,
    required this.gender,
    required this.lastNameKu,
    required this.lastNameAr,
    required this.lastNameEn,
    required this.profilePicture,
  });

  final String? id;
  final String? firstName;
  final String? firstNameKu;
  final String? firstNameEn;
  final String? firstNameAr;
  final String? username;
  final String? gender;
  final String? lastNameKu;
  final String? lastNameAr;
  final String? lastNameEn;
  final ProfilePicture? profilePicture;

  factory ErId.fromJson(Map<String, dynamic> json) {
    return ErId(
      id: json["_id"],
      firstName: json["firstName"],
      firstNameKu: json["firstName_ku"],
      firstNameEn: json["firstName_en"],
      firstNameAr: json["firstName_ar"],
      username: json["username"],
      gender: json["gender"],
      lastNameKu: json["lastName_ku"],
      lastNameAr: json["lastName_ar"],
      lastNameEn: json["lastName_en"],
      profilePicture: json["profilePicture"] == null
          ? null
          : ProfilePicture.fromJson(json["profilePicture"]),
    );
  }
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
}
