// To parse this JSON data, do
//
//     final homePagetModel = homePagetModelFromJson(jsonString);

import 'dart:convert';

HomePagetModel homePagetModelFromJson(String str) => HomePagetModel.fromJson(json.decode(str));

String homePagetModelToJson(HomePagetModel data) => json.encode(data.toJson());

class HomePagetModel {
  bool? success;
  String? message;
  int? status;
  List<Post> posts;

  HomePagetModel({
    this.success,
    this.message,
    this.status,
    required this.posts,
  });

  factory HomePagetModel.fromJson(Map<String, dynamic> json) => HomePagetModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "posts": posts == null ? [] : List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  int? id;
  String? userId;
  String? postName;
  String? post;
  String? miniblogs;
  String? postType;
  String? caption;
  int totalComments;
  int totalLikes;
  String? mentions;
  String? createdAt;
  DateTime? updatedAt;
  List<MentionsDatum>? mentionsData;
  String? likedByUser;
  List<MentionsDatum>? postOwnerInfo;
  List<Comment>? comments;
  int? ad;
  int? businessId;
  int? age;
  String? title;
  String? interest;
  int? budget;
  String? campaignDuration;
  String? adImage;
  String? address;
  String? link;
  String? rangeKm;

  Post({
    this.id,
    this.userId,
    this.postName,
    this.post,
    this.miniblogs,
    this.postType,
    this.caption,
    required this.totalComments,
    required this.totalLikes,
    this.mentions,
    this.createdAt,
    this.updatedAt,
    this.mentionsData,
    this.likedByUser,
    this.postOwnerInfo,
    this.comments,
    this.ad,
    this.businessId,
    this.age,
    this.title,
    this.interest,
    this.budget,
    this.campaignDuration,
    this.adImage,
    this.address,
    this.link,
    this.rangeKm,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        userId: json["user_id"],
        postName: json["post_name"],
        post: json["post"],
        miniblogs: json["miniblogs"],
        postType: json["post_type"],
        caption: json["caption"],
        totalComments: json["total_comments"] ?? 0,
        totalLikes: json["total_likes"] ?? 0,
        mentions: json["mentions"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        mentionsData: json["mentions_data"] == null ? [] : List<MentionsDatum>.from(json["mentions_data"]!.map((x) => MentionsDatum.fromJson(x))),
        likedByUser: json["liked_by_user"],
        postOwnerInfo: json["post_owner_info"] == null ? [] : List<MentionsDatum>.from(json["post_owner_info"]!.map((x) => MentionsDatum.fromJson(x))),
        comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
        ad: json["AD"],
        businessId: json["business_id"],
        age: json["age"],
        title: json["title"],
        interest: json["interest"],
        budget: json["budget"],
        campaignDuration: json["campaign_duration"],
        adImage: json["ad_image"],
        address: json["address"],
        link: json["link"],
        rangeKm: json["range_km"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "post_name": postName,
        "post": post,
        "miniblogs": miniblogs,
        "post_type": postType,
        "caption": caption,
        "total_comments": totalComments,
        "total_likes": totalLikes,
        "mentions": mentions,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
        "mentions_data": mentionsData == null ? [] : List<dynamic>.from(mentionsData!.map((x) => x.toJson())),
        "liked_by_user": likedByUser,
        "post_owner_info": postOwnerInfo == null ? [] : List<dynamic>.from(postOwnerInfo!.map((x) => x.toJson())),
        "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "AD": ad,
        "business_id": businessId,
        "age": age,
        "title": title,
        "interest": interest,
        "budget": budget,
        "campaign_duration": campaignDuration,
        "ad_image": adImage,
        "address": address,
        "link": link,
        "range_km": rangeKm,
      };
}

class Comment {
  int? id;
  int? userId;
  int? postId;
  String? postComment;
  DateTime? updatedAt;
  DateTime? createdAt;
  String? commentOwnerName;
  String? profileImage;

  Comment({
    this.id,
    this.userId,
    this.postId,
    this.postComment,
    this.updatedAt,
    this.createdAt,
    this.commentOwnerName,
    this.profileImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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

class MentionsDatum {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? username;
  String? email;
  String? showPassword;
  String? password;
  String? phoneNumber;
  int? otp;
  int? age;
  int? trending;
  String? dob;
  String? height;
  UserType? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  String? interest;
  String? hobbies;
  String? gender;
  String? address;
  String? logitude;
  String? latitude;
  String? proplan;
  int? profileStatus;
  String? token;
  int? kyc;
  String? actToken;
  double? totalReviewStar;
  int? onlineStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  MentionsDatum({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.username,
    this.email,
    this.showPassword,
    this.password,
    this.phoneNumber,
    this.otp,
    this.age,
    this.trending,
    this.dob,
    this.height,
    this.userType,
    this.fcmToken,
    this.verifyUser,
    this.phoneVerify,
    this.interest,
    this.hobbies,
    this.gender,
    this.address,
    this.logitude,
    this.latitude,
    this.proplan,
    this.profileStatus,
    this.token,
    this.kyc,
    this.actToken,
    this.totalReviewStar,
    this.onlineStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory MentionsDatum.fromJson(Map<String, dynamic> json) => MentionsDatum(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
        username: json["username"],
        email: json["email"],
        showPassword: json["show_password"],
        password: json["password"],
        phoneNumber: json["phone_number"],
        otp: json["OTP"],
        age: json["age"],
        trending: json["trending"],
        dob: json["DOB"],
        height: json["height"],
        userType: userTypeValues.map[json["user_type"]]!,
        fcmToken: json["fcm_token"],
        verifyUser: json["verify_user"],
        phoneVerify: json["phone_verify"],
        interest: json["Interest"],
        hobbies: json["hobbies"],
        gender: json["gender"],
        address: json["address"],
        logitude: json["logitude"],
        latitude: json["latitude"],
        proplan: json["pro_plan"],
        profileStatus: json["profile_status"],
        token: json["token"],
        kyc: json["KYC"],
        actToken: json["act_token"],
        totalReviewStar: json["Total_review_star"]?.toDouble(),
        onlineStatus: json["online_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
        "username": username,
        "email": email,
        "show_password": showPassword,
        "password": password,
        "phone_number": phoneNumber,
        "OTP": otp,
        "age": age,
        "trending": trending,
        "DOB": dob,
        "height": height,
        "user_type": userTypeValues.reverse[userType],
        "fcm_token": fcmToken,
        "verify_user": verifyUser,
        "phone_verify": phoneVerify,
        "Interest": interest,
        "hobbies": hobbies,
        "gender": gender,
        "address": address,
        "logitude": logitude,
        "latitude": latitude,
        "proplan": proplan,
        "profile_status": profileStatus,
        "token": token,
        "KYC": kyc,
        "act_token": actToken,
        "Total_review_star": totalReviewStar,
        "online_status": onlineStatus,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum UserType { USER }

final userTypeValues = EnumValues({"user": UserType.USER});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
