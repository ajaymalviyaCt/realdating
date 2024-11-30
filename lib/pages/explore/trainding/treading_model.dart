// To parse this JSON data, do
//
//     final treadingModel = treadingModelFromJson(jsonString);

import 'dart:convert';

TreadingModel treadingModelFromJson(String str) => TreadingModel.fromJson(json.decode(str));

String treadingModelToJson(TreadingModel data) => json.encode(data.toJson());

class TreadingModel {
  bool? success;
  String? message;
  int? status;
  List<TrendingUser>? trendingUser;

  TreadingModel({
    this.success,
    this.message,
    this.status,
    this.trendingUser,
  });

  factory TreadingModel.fromJson(Map<String, dynamic> json) => TreadingModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        trendingUser: json["Trending_User"] == null ? [] : List<TrendingUser>.from(json["Trending_User"]!.map((x) => TrendingUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "Trending_User": trendingUser == null ? [] : List<dynamic>.from(trendingUser!.map((x) => x.toJson())),
      };
}

class TrendingUser {
  int? id;
  String? firstName;
  int? friend;
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
  String? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  String? interest;
  String? hobbies;
  String? gender;
  String? address;
  String? logitude;
  String? latitude;
  int? profileStatus;
  String? token;
  int? kyc;
  String? actToken;
  int? totalReviewStar;
  int? onlineStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ProfileImage>? profileImages;

  TrendingUser({
    this.id,
    this.friend,
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
    this.profileStatus,
    this.token,
    this.kyc,
    this.actToken,
    this.totalReviewStar,
    this.onlineStatus,
    this.createdAt,
    this.updatedAt,
    this.profileImages,
  });

  factory TrendingUser.fromJson(Map<String, dynamic> json) => TrendingUser(
        id: json["id"],
        firstName: json["first_name"],
        friend: json["friend"],
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
        // totalReviewStar: json["Total_review_star"],
        onlineStatus: json["online_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        profileImages: json["profile_images"] == null ? [] : List<ProfileImage>.from(json["profile_images"]!.map((x) => ProfileImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "friend": friend,
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile_images": profileImages == null ? [] : List<dynamic>.from(profileImages!.map((x) => x.toJson())),
      };
}

class ProfileImage {
  String? profileImages;

  ProfileImage({
    this.profileImages,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        profileImages: json["profile_images"],
      );

  Map<String, dynamic> toJson() => {
        "profile_images": profileImages,
      };
}
