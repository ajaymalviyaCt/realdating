// To parse this JSON data, do
//
//     final bcommentsModel = bcommentsModelFromJson(jsonString);

import 'dart:convert';

BcommentsModel bcommentsModelFromJson(String str) => BcommentsModel.fromJson(json.decode(str));

String bcommentsModelToJson(BcommentsModel data) => json.encode(data.toJson());

class BcommentsModel {
  bool? success;
  String? message;
  int? status;
  List<BComments> comments;

  BcommentsModel({
    this.success,
    this.message,
    this.status,
    required this.comments,
  });

  factory BcommentsModel.fromJson(Map<String, dynamic> json) => BcommentsModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        comments: json["comments"] == null ? [] : List<BComments>.from(json["comments"]!.map((x) => BComments.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "comments": comments,
      };
}

class BComments {
  int? id;
  int? businessId;
  int? postId;
  String? postComment;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? commentOwnerName;
  String? profileImage;

  BComments({
    this.id,
    this.businessId,
    this.postId,
    this.postComment,
    this.createdAt,
    this.updatedAt,
    this.commentOwnerName,
    this.profileImage,
  });

  factory BComments.fromJson(Map<String, dynamic> json) => BComments(
        id: json["id"],
        businessId: json["business_id"],
        postId: json["post_id"],
        postComment: json["post_comment"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        commentOwnerName: json["comment_owner_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "post_id": postId,
        "post_comment": postComment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "comment_owner_name": commentOwnerName,
        "profile_image": profileImage,
      };
}
