// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);

import 'dart:convert';

CommentsModel commentsModelFromJson(String str) => CommentsModel.fromJson(json.decode(str));

String commentsModelToJson(CommentsModel data) => json.encode(data.toJson());

class CommentsModel {
  bool? success;
  String? message;
  int? status;
  List<CommentList>? comments;

  CommentsModel({
    this.success,
    this.message,
    this.status,
    this.comments,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        comments: json["Comments"] == null ? [] : List<CommentList>.from(json["Comments"]!.map((x) => CommentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "Comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class CommentList {
  int? id;
  int? userId;
  int? postId;
  String? postComment;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? commentOwnerName;
  String? profileImage;

  CommentList({
    this.id,
    this.userId,
    this.postId,
    this.postComment,
    this.updatedAt,
    this.createdAt,
    this.commentOwnerName,
    this.profileImage,
  });

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
        id: json["id"],
        userId: json["user_id"],
        postId: json["post_id"],
        postComment: json["post_comment"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        commentOwnerName: json["comment_owner_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_id": postId,
        "post_comment": postComment,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "comment_owner_name": commentOwnerName,
        "profile_image": profileImage,
      };
}
