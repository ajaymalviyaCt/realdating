// To parse this JSON data, do
//
//     final getReelsModel = getReelsModelFromJson(jsonString);

import 'dart:convert';

GetReelsModel getReelsModelFromJson(String str) => GetReelsModel.fromJson(json.decode(str));

String getReelsModelToJson(GetReelsModel data) => json.encode(data.toJson());

class GetReelsModel {
  bool success;
  String message;
  int status;
  List<Reel> reels;

  GetReelsModel({
    required this.success,
    required this.message,
    required this.status,
    required this.reels,
  });

  GetReelsModel copyWith({
    bool? success,
    String? message,
    int? status,
    List<Reel>? reels,
  }) =>
      GetReelsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        status: status ?? this.status,
        reels: reels ?? this.reels,
      );

  factory GetReelsModel.fromJson(Map<String, dynamic> json) => GetReelsModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    reels: List<Reel>.from(json["reels"].map((x) => Reel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "reels": List<dynamic>.from(reels.map((x) => x.toJson())),
  };
}

class Reel {
  int id;
  String reelName;
  String reel;
  int userId;
  int totalLikes;
  int totalComments;
  DateTime updatedAt;
  DateTime createdAt;
  List<UserInfo> userInfo;

  Reel({
    required this.id,
    required this.reelName,
    required this.reel,
    required this.userId,
    required this.totalLikes,
    required this.totalComments,
    required this.updatedAt,
    required this.createdAt,
    required this.userInfo,
  });

  Reel copyWith({
    int? id,
    String? reelName,
    String? reel,
    int? userId,
    int? totalLikes,
    int? totalComments,
    DateTime? updatedAt,
    DateTime? createdAt,
    List<UserInfo>? userInfo,
  }) =>
      Reel(
        id: id ?? this.id,
        reelName: reelName ?? this.reelName,
        reel: reel ?? this.reel,
        userId: userId ?? this.userId,
        totalLikes: totalLikes ?? this.totalLikes,
        totalComments: totalComments ?? this.totalComments,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        userInfo: userInfo ?? this.userInfo,
      );

  factory Reel.fromJson(Map<String, dynamic> json) => Reel(
    id: json["id"],
    reelName: json["reel_name"],
    reel: json["reel"],
    userId: json["user_id"],
    totalLikes: json["total_likes"],
    totalComments: json["total_comments"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    userInfo: List<UserInfo>.from(json["user_info"].map((x) => UserInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reel_name": reelName,
    "reel": reel,
    "user_id": userId,
    "total_likes": totalLikes,
    "total_comments": totalComments,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "user_info": List<dynamic>.from(userInfo.map((x) => x.toJson())),
  };
}

class UserInfo {
  int id;
  String firstName;
  String lastName;
  String profileImage;
  String username;
  String email;
  String showPassword;
  String password;
  String phoneNumber;
  int otp;
  int age;
  int trending;
  String dob;
  String height;
  String userType;
  String fcmToken;
  int verifyUser;
  int phoneVerify;
  String interest;
  String hobbies;
  String gender;
  String address;
  String logitude;
  String latitude;
  int profileStatus;
  String token;
  int kyc;
  String actToken;
  double totalReviewStar;
  int onlineStatus;
  DateTime createdAt;
  DateTime updatedAt;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.username,
    required this.email,
    required this.showPassword,
    required this.password,
    required this.phoneNumber,
    required this.otp,
    required this.age,
    required this.trending,
    required this.dob,
    required this.height,
    required this.userType,
    required this.fcmToken,
    required this.verifyUser,
    required this.phoneVerify,
    required this.interest,
    required this.hobbies,
    required this.gender,
    required this.address,
    required this.logitude,
    required this.latitude,
    required this.profileStatus,
    required this.token,
    required this.kyc,
    required this.actToken,
    required this.totalReviewStar,
    required this.onlineStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  UserInfo copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? profileImage,
    String? username,
    String? email,
    String? showPassword,
    String? password,
    String? phoneNumber,
    int? otp,
    int? age,
    int? trending,
    String? dob,
    String? height,
    String? userType,
    String? fcmToken,
    int? verifyUser,
    int? phoneVerify,
    String? interest,
    String? hobbies,
    String? gender,
    String? address,
    String? logitude,
    String? latitude,
    int? profileStatus,
    String? token,
    int? kyc,
    String? actToken,
    double? totalReviewStar,
    int? onlineStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UserInfo(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        profileImage: profileImage ?? this.profileImage,
        username: username ?? this.username,
        email: email ?? this.email,
        showPassword: showPassword ?? this.showPassword,
        password: password ?? this.password,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        otp: otp ?? this.otp,
        age: age ?? this.age,
        trending: trending ?? this.trending,
        dob: dob ?? this.dob,
        height: height ?? this.height,
        userType: userType ?? this.userType,
        fcmToken: fcmToken ?? this.fcmToken,
        verifyUser: verifyUser ?? this.verifyUser,
        phoneVerify: phoneVerify ?? this.phoneVerify,
        interest: interest ?? this.interest,
        hobbies: hobbies ?? this.hobbies,
        gender: gender ?? this.gender,
        address: address ?? this.address,
        logitude: logitude ?? this.logitude,
        latitude: latitude ?? this.latitude,
        profileStatus: profileStatus ?? this.profileStatus,
        token: token ?? this.token,
        kyc: kyc ?? this.kyc,
        actToken: actToken ?? this.actToken,
        totalReviewStar: totalReviewStar ?? this.totalReviewStar,
        onlineStatus: onlineStatus ?? this.onlineStatus,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
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
    userType: json["user_type"],
    fcmToken: json["fcm_token"],
    verifyUser: json["verify_user"],
    phoneVerify: json["phone_verify"],
    interest: json["Interest"],
    hobbies: json["hobbies"],
    gender: json["gender"],
    address: json["address"],
    logitude: json["logitude"],
    latitude: json["latitude"],
    profileStatus: json["profile_status"],
    token: json["token"],
    kyc: json["KYC"],
    actToken: json["act_token"],
    totalReviewStar: json["Total_review_star"]?.toDouble(),
    onlineStatus: json["online_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
    "user_type": userType,
    "fcm_token": fcmToken,
    "verify_user": verifyUser,
    "phone_verify": phoneVerify,
    "Interest": interest,
    "hobbies": hobbies,
    "gender": gender,
    "address": address,
    "logitude": logitude,
    "latitude": latitude,
    "profile_status": profileStatus,
    "token": token,
    "KYC": kyc,
    "act_token": actToken,
    "Total_review_star": totalReviewStar,
    "online_status": onlineStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
