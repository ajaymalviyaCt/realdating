// To parse this JSON data, do
//
//     final getClassifiedRequestModel = getClassifiedRequestModelFromJson(jsonString);

import 'dart:convert';

GetClassifiedRequestModel getClassifiedRequestModelFromJson(String str) => GetClassifiedRequestModel.fromJson(json.decode(str));

String getClassifiedRequestModelToJson(GetClassifiedRequestModel data) => json.encode(data.toJson());

class GetClassifiedRequestModel {
  bool? success;
  String? message;
  int? status;
  List<ClassifiedRequest>? classifiedRequest;

  GetClassifiedRequestModel({
    this.success,
    this.message,
    this.status,
    this.classifiedRequest,
  });

  factory GetClassifiedRequestModel.fromJson(Map<String, dynamic> json) => GetClassifiedRequestModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    classifiedRequest: json["classified_request"] == null ? [] : List<ClassifiedRequest>.from(json["classified_request"]!.map((x) => ClassifiedRequest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "classified_request": classifiedRequest == null ? [] : List<dynamic>.from(classifiedRequest!.map((x) => x.toJson())),
  };
}

class ClassifiedRequest {
  int? id;
  String? date;
  String? time;
  String activity;
  String? location;
  int? invitedTo;
  InvitedBy? invitedBy;
  int? classifiedPost;
  int? classifiedPostStatus;
  int? status;
  DateTime? createdAt;

  ClassifiedRequest({
    this.id,
    this.date,
    this.time,
    required this.activity,
    this.location,
    this.invitedTo,
    this.invitedBy,
    this.classifiedPost,
    this.classifiedPostStatus,
    this.status,
    this.createdAt,
  });

  factory ClassifiedRequest.fromJson(Map<String, dynamic> json) => ClassifiedRequest(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    activity: json["activity"],
    location: json["location"],
    invitedTo: json["invited_to"],
    invitedBy: json["invited_by"] == null ? null : InvitedBy.fromJson(json["invited_by"]),
    classifiedPost: json["classified_post"],
    classifiedPostStatus: json["classified_post_status"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "time": time,
    "activity": activity,
    "location": location,
    "invited_to": invitedTo,
    "invited_by": invitedBy?.toJson(),
    "classified_post": classifiedPost,
    "classified_post_status": classifiedPostStatus,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
  };
}

class InvitedBy {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? username;
  String? email;
  String? password;
  String? showPassword;
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
  int? onlineStatus;
  DateTime? createdAt;
  DateTime? updateAt;

  InvitedBy({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.username,
    this.email,
    this.password,
    this.showPassword,
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
    this.onlineStatus,
    this.createdAt,
    this.updateAt,
  });

  factory InvitedBy.fromJson(Map<String, dynamic> json) => InvitedBy(
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
    onlineStatus: json["online_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updateAt: json["update_at"] == null ? null : DateTime.parse(json["update_at"]),
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
    "online_status": onlineStatus,
    "created_at": createdAt?.toIso8601String(),
    "update_at": updateAt?.toIso8601String(),
  };
}
