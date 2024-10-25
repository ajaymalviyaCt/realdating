// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int status;
  bool success;
  String message;
  UserInfo userInfo;

  ProfileModel({
    required this.status,
    required this.success,
    required this.message,
    required this.userInfo,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    userInfo: UserInfo.fromJson(json["user_info"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "user_info": userInfo.toJson(),
  };
}

class UserInfo {
  int id;
  String firstName;
  String lastName;
  String profileImage;
  String username;
  String email;
  String password;
  String showPassword;
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
  var totalReviewStar;
  int onlineStatus;
  DateTime createdAt;
  DateTime updateAt;
  List<Image> images;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.username,
    required this.email,
    required this.password,
    required this.showPassword,
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
    required this.updateAt,
    required this.images,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    showPassword: json["show_password"],
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
    createdAt: DateTime.parse(json["created_at"]),
    updateAt: DateTime.parse(json["updated_at"]),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
    "username": username,
    "email": email,
    "password": password,
    "show_password": showPassword,
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
    "update_at": updateAt.toIso8601String(),
    "images": List<Image>.from(images.map((x) => x.toJson())),
  };
}

class Image {
  String profileImages;

  Image({
    required this.profileImages,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    profileImages: json["profile_images"],
  );

  Map<String, dynamic> toJson() => {
    "profile_images": profileImages,
  };
}
