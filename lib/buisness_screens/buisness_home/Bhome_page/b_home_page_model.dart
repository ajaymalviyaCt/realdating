// To parse this JSON data, do
//
//     final bHomePagetModel = bHomePagetModelFromJson(jsonString);

import 'dart:convert';

BHomePagetModel bHomePagetModelFromJson(String str) => BHomePagetModel.fromJson(json.decode(str));

String bHomePagetModelToJson(BHomePagetModel data) => json.encode(data.toJson());

class BHomePagetModel {
  bool? success;
  String? message;
  int? status;
  List<BPost> posts;

  BHomePagetModel({
    this.success,
    this.message,
    this.status,
     required this.posts,
  });

  factory BHomePagetModel.fromJson(Map<String, dynamic> json) => BHomePagetModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    posts: json["posts"] == null ? [] : List<BPost>.from(json["posts"]!.map((x) => BPost.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "posts": posts,
  };
}

class BPost {
  int? id;
  int? businessId;
  String? postName;
  String? post;
  String? caption;
  String? miniblogs;
  String? postType;
  int? totalLikes;
  int? totalComments;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? likedByUser;
  String? businessName;
  String? profileImage;
  List<LikesInfo>? likesInfo;
  List<Comment>? comments;

  BPost({
    this.id,
    this.businessId,
    this.postName,
    this.post,
    this.caption,
    this.miniblogs,
    this.postType,
    this.totalLikes,
    this.totalComments,
    this.createdAt,
    this.updatedAt,
    this.likedByUser,
    this.businessName,
    this.profileImage,
    this.likesInfo,
    this.comments,
  });

  factory BPost.fromJson(Map<String, dynamic> json) => BPost(
    id: json["id"],
    businessId: json["business_id"],
    postName: json["post_name"],
    post: json["post"],
    caption: json["caption"],
    miniblogs: json["miniblogs"],
    postType: json["post_type"],
    totalLikes: json["total_likes"],
    totalComments: json["total_comments"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    likedByUser: json["liked_by_user"],
    businessName: json["business_name"],
    profileImage: json["profile_image"],
    likesInfo: json["likes_info"] == null ? [] : List<LikesInfo>.from(json["likes_info"]!.map((x) => LikesInfo.fromJson(x))),
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "post_name": postName,
    "post": post,
    "caption": caption,
    "miniblogs": miniblogs,
    "post_type": postType,
    "total_likes": totalLikes,
    "total_comments": totalComments,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "liked_by_user": likedByUser,
    "business_name": businessName,
    "profile_image": profileImage,
    "likes_info": likesInfo == null ? [] : List<dynamic>.from(likesInfo!.map((x) => x.toJson())),
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comment {
  int? id;
  int? businessId;
  int? postId;
  String? postComment;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? commentOwnerName;
  String? profileImage;

  Comment({
    this.id,
    this.businessId,
    this.postId,
    this.postComment,
    this.createdAt,
    this.updatedAt,
    this.commentOwnerName,
    this.profileImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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

class LikesInfo {
  int? id;
  int? businessId;
  int? postId;
  int? like;
  int? totalLikes;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? likeOwnerName;
  String? profileImage;

  LikesInfo({
    this.id,
    this.businessId,
    this.postId,
    this.like,
    this.totalLikes,
    this.updatedAt,
    this.createdAt,
    this.likeOwnerName,
    this.profileImage,
  });

  factory LikesInfo.fromJson(Map<String, dynamic> json) => LikesInfo(
    id: json["id"],
    businessId: json["business_id"],
    postId: json["post_id"],
    like: json["like"],
    totalLikes: json["total_likes"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    likeOwnerName: json["like_owner_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "post_id": postId,
    "like": like,
    "total_likes": totalLikes,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "like_owner_name": likeOwnerName,
    "profile_image": profileImage,
  };
}
