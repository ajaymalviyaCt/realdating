// To parse this JSON data, do
//
//     final allBusinessPostModel = allBusinessPostModelFromJson(jsonString);

import 'dart:convert';

AllBusinessPostModel allBusinessPostModelFromJson(String str) => AllBusinessPostModel.fromJson(json.decode(str));

String allBusinessPostModelToJson(AllBusinessPostModel data) => json.encode(data.toJson());

class AllBusinessPostModel {
  bool success;
  String message;
  int status;
  List<Post> posts;

  AllBusinessPostModel({
    required this.success,
    required this.message,
    required this.status,
    required this.posts,
  });

  AllBusinessPostModel copyWith({
    bool? success,
    String? message,
    int? status,
    List<Post>? posts,
  }) =>
      AllBusinessPostModel(
        success: success ?? this.success,
        message: message ?? this.message,
        status: status ?? this.status,
        posts: posts ?? this.posts,
      );

  factory AllBusinessPostModel.fromJson(Map<String, dynamic> json) => AllBusinessPostModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
  };
}

class Post {
  int id;
  int businessId;
  String postName;
  String post;
  String caption;
  String miniblogs;
  String postType;
  int totalLikes;
  int totalComments;
  DateTime createdAt;
  DateTime updatedAt;
  String likedByUser;
  String businessName;
  String profileImage;
  List<dynamic> likesInfo;
  List<dynamic> comments;

  Post({
    required this.id,
    required this.businessId,
    required this.postName,
    required this.post,
    required this.caption,
    required this.miniblogs,
    required this.postType,
    required this.totalLikes,
    required this.totalComments,
    required this.createdAt,
    required this.updatedAt,
    required this.likedByUser,
    required this.businessName,
    required this.profileImage,
    required this.likesInfo,
    required this.comments,
  });

  Post copyWith({
    int? id,
    int? businessId,
    String? postName,
    String? post,
    String? caption,
    String? miniblogs,
    String? postType,
    int? totalLikes,
    int? totalComments,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? likedByUser,
    String? businessName,
    String? profileImage,
    List<dynamic>? likesInfo,
    List<dynamic>? comments,
  }) =>
      Post(
        id: id ?? this.id,
        businessId: businessId ?? this.businessId,
        postName: postName ?? this.postName,
        post: post ?? this.post,
        caption: caption ?? this.caption,
        miniblogs: miniblogs ?? this.miniblogs,
        postType: postType ?? this.postType,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        likedByUser: likedByUser ?? this.likedByUser,
        businessName: businessName ?? this.businessName,
        profileImage: profileImage ?? this.profileImage,
        likesInfo: likesInfo ?? this.likesInfo,
        comments: comments ?? this.comments,
      );

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    businessId: json["business_id"],
    postName: json["post_name"],
    post: json["post"],
    caption: json["caption"],
    miniblogs: json["miniblogs"],
    postType: json["post_type"],
    totalLikes: json["total_likes"],
    totalComments: json["total_comments"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    likedByUser: json["liked_by_user"],
    businessName: json["business_name"]??"",
    profileImage: json["profile_image"]??"",
    likesInfo: List<dynamic>.from(json["likes_info"].map((x) => x)),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "liked_by_user": likedByUser,
    "business_name": businessName??"",
    "profile_image": profileImage??"",
    "likes_info": List<dynamic>.from(likesInfo.map((x) => x)),
    "comments": List<dynamic>.from(comments.map((x) => x)),
  };

}
class Comment {
  int id;
  int businessId;
  int postId;
  String postComment;
  DateTime createdAt;
  DateTime updatedAt;
  String commentOwnerName;
  String profileImage;

  Comment({
    required this.id,
    required this.businessId,
    required this.postId,
    required this.postComment,
    required this.createdAt,
    required this.updatedAt,
    required this.commentOwnerName,
    required this.profileImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    businessId: json["business_id"],
    postId: json["post_id"],
    postComment: json["post_comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    commentOwnerName: json["comment_owner_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "post_id": postId,
    "post_comment": postComment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "comment_owner_name": commentOwnerName,
    "profile_image": profileImage,
  };
}
