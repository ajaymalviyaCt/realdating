// To parse this JSON data, do
//
//     final discoveryModel = discoveryModelFromJson(jsonString);

import 'dart:convert';

DiscoveryModel discoveryModelFromJson(String str) => DiscoveryModel.fromJson(json.decode(str));

String discoveryModelToJson(DiscoveryModel data) => json.encode(data.toJson());

class DiscoveryModel {
  String? message;
  List<MyFriend> myFriends;
  bool? success;
  int? status;

  DiscoveryModel({
    this.message,
    required this.myFriends,
    this.success,
    this.status,
  });

  factory DiscoveryModel.fromJson(Map<String, dynamic> json) => DiscoveryModel(
        message: json["message"],
        myFriends: json["my_friends"] == null ? [] : List<MyFriend>.from(json["my_friends"]!.map((x) => MyFriend.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "my_friends": myFriends == null ? [] : List<dynamic>.from(myFriends.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class MyFriend {
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
  List<Image>? images;

  MyFriend({
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
    this.profileStatus,
    this.token,
    this.kyc,
    this.actToken,
    this.totalReviewStar,
    this.onlineStatus,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory MyFriend.fromJson(Map<String, dynamic> json) => MyFriend(
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
        totalReviewStar: json["Total_review_star"],
        onlineStatus: json["online_status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
      };
}

class Image {
  String? profileImages;

  Image({
    this.profileImages,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        profileImages: json["profile_images"],
      );

  Map<String, dynamic> toJson() => {
        "profile_images": profileImages,
      };
}
