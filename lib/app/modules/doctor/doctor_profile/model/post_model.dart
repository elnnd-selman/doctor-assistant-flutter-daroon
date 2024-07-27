// class ContentModel {
//   ContentModel({
//     required this.data,
//     required this.paginationCount,
//   });

//   final List<ContentData> data;
//   final int? paginationCount;

//   factory ContentModel.fromJson(Map<String, dynamic> json) {
//     return ContentModel(
//       data: json["data"] == null
//           ? []
//           : List<ContentData>.from(
//               json["data"]!.map((x) => ContentData.fromJson(x))),
//       paginationCount: json["paginationCount"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "data": data.map((x) => x.toJson()).toList(),
//         "paginationCount": paginationCount,
//       };
// }

// class ContentData {
//   ContentData({
//     required this.id,
//     required this.user,
//     required this.title,
//     required this.content,
//     required this.images,
//     required this.videos,
//     required this.isPrivate,
//     required this.sizeOfContents,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//     required this.likes,
//     required this.type,
//   });

//   final String? id;
//   final UserData? user;
//   final String? title;
//   final String? content;
//   final List<String> images;
//   final List<dynamic> videos;
//   final bool? isPrivate;
//   // ignore: prefer_typing_uninitialized_variables
//   var sizeOfContents;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final int? v;
//   final int? likes;
//   final String? type;

//   factory ContentData.fromJson(Map<String, dynamic> json) {
//     return ContentData(
//       id: json["_id"],
//       user: json["user"] == null ? null : UserData.fromJson(json["user"]),
//       title: json["title"],
//       content: json["content"],
//       images: json["images"] == null
//           ? []
//           : List<String>.from(json["images"]!.map((x) => x)),
//       videos: json["videos"] == null
//           ? []
//           : List<dynamic>.from(json["videos"]!.map((x) => x)),
//       isPrivate: json["isPrivate"],
//       sizeOfContents: json["sizeOfContents"],
//       createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
//       updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
//       v: json["__v"],
//       likes: json["likes"],
//       type: json["type"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "user": user?.toJson(),
//         "title": title,
//         "content": content,
//         "images": images.map((x) => x).toList(),
//         "videos": videos.map((x) => x).toList(),
//         "isPrivate": isPrivate,
//         "sizeOfContents": sizeOfContents,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//         "likes": likes,
//         "type": type,
//       };
// }

// class UserData {
//   UserData({
//     required this.id,
//     required this.name,
//   });

//   final String? id;
//   final String? name;

//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       id: json["_id"],
//       name: json["name"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//       };
// }

class ContentModel {
  ContentModel({
    required this.data,
    required this.paginationCount,
    required this.currentPage,
    required this.totalRecord,
  });

  final List<ContentData> data;
  final int? paginationCount;
  final int? currentPage;
  final int? totalRecord;

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      data: json["data"] == null
          ? []
          : List<ContentData>.from(
              json["data"]!.map((x) => ContentData.fromJson(x))),
      paginationCount: json["paginationCount"],
      currentPage: json["currentPage"],
      totalRecord: json["totalRecord"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
        "paginationCount": paginationCount,
        "currentPage": currentPage,
        "totalRecord": totalRecord,
      };
}

class ContentData {
  ContentData({
    required this.id,
    required this.user,
    required this.titleKu,
    required this.titleEn,
    required this.titleAr,
    required this.contentKu,
    required this.contentAr,
    required this.contentEn,
    required this.images,
    required this.videos,
    required this.isPrivate,
    // required this.sizeOfContents,
    required this.contentType,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likes,
    required this.type,
  });

  final String? id;
  final User? user;
  final String? titleKu;
  final String? titleEn;
  final String? titleAr;
  final String? contentKu;
  final String? contentAr;
  final String? contentEn;
  final List<String> images;
  final List<String> videos;
  final bool? isPrivate;
  // final double? sizeOfContents;
  final String? contentType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? likes;
  final String? type;

  factory ContentData.fromJson(Map<String, dynamic> json) {
    return ContentData(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      titleKu: json["title_ku"],
      titleEn: json["title_en"],
      titleAr: json["title_ar"],
      contentKu: json["content_ku"],
      contentAr: json["content_ar"],
      contentEn: json["content_en"],
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      videos: json["videos"] == null
          ? []
          : List<String>.from(json["videos"]!.map((x) => x)),
      isPrivate: json["isPrivate"],
      // sizeOfContents: json["sizeOfContents"],
      contentType: json["contentType"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      likes: json["likes"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "title_ku": titleKu,
        "title_en": titleEn,
        "title_ar": titleAr,
        "content_ku": contentKu,
        "content_ar": contentAr,
        "content_en": contentEn,
        "images": images.map((x) => x).toList(),
        "videos": videos.map((x) => x).toList(),
        "isPrivate": isPrivate,
        // "sizeOfContents": sizeOfContents,
        "contentType": contentType,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "likes": likes,
        "type": type,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.usePictureAsLink,
  });

  final String? id;
  final String? name;
  final bool? usePictureAsLink;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      name: json["name"],
      usePictureAsLink: json["usePictureAsLink"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "usePictureAsLink": usePictureAsLink,
      };
}
