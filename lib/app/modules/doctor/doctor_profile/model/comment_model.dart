class CommentModel {
  CommentModel({
    required this.data,
    required this.success,
    required this.status,
  });

  final List<CommentReplyModel> data;
  final bool? success;
  final int? status;

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      data: json["data"] == null
          ? []
          : List<CommentReplyModel>.from(
              json["data"]!.map((x) => CommentReplyModel.fromJson(x))),
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

class CommentReplyModel {
  CommentReplyModel({
    required this.id,
    required this.user,
    required this.content,
    required this.parentComment,
    required this.comment,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likes,
    required this.replies,
  });

  final String? id;
  final User? user;
  final String? content;
  final String? parentComment;
  final String? comment;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final int? likes;
  final List<CommentReplyModel> replies;

  factory CommentReplyModel.fromJson(Map<String, dynamic> json) {
    return CommentReplyModel(
      id: json["_id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      content: json["content"],
      parentComment: json["parentComment"],
      comment: json["comment"],
      isDeleted: json["isDeleted"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      likes: json["likes"],
      replies: json["parentComment"] == null
          ? []
          : json["replies"] == null
              ? []
              : List<CommentReplyModel>.from(
                  json["replies"]!.map((x) => CommentReplyModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "content": content,
        "parentComment": parentComment,
        "comment": comment,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "likes": likes,
        "replies": replies.map((x) => x.toJson()).toList(),
      };
}

class User {
  User({
    required this.id,
    required this.usePictureAsLink,
  });

  final String? id;
  final bool? usePictureAsLink;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["_id"],
      usePictureAsLink: json["usePictureAsLink"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "usePictureAsLink": usePictureAsLink,
      };
}
