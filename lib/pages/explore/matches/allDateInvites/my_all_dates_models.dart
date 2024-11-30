// To parse this JSON data, do
//
//     final myAllDatesModel001 = myAllDatesModel001FromJson(jsonString);

import 'dart:convert';

MyAllDatesModel001 myAllDatesModel001FromJson(String str) => MyAllDatesModel001.fromJson(json.decode(str));

String myAllDatesModel001ToJson(MyAllDatesModel001 data) => json.encode(data.toJson());

class MyAllDatesModel001 {
  bool? success;
  String? message;
  int? status;
  List<MyInvite>? myInvites;

  MyAllDatesModel001({
    this.success,
    this.message,
    this.status,
    this.myInvites,
  });

  factory MyAllDatesModel001.fromJson(Map<String, dynamic> json) => MyAllDatesModel001(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        myInvites: json["My_invites"] == null ? [] : List<MyInvite>.from(json["My_invites"]!.map((x) => MyInvite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "My_invites": myInvites == null ? [] : List<dynamic>.from(myInvites!.map((x) => x.toJson())),
      };
}

class MyInvite {
  int? id;
  String? date;
  String? time;
  String? activity;
  String? location;
  Invited? invitedTo;
  Invited? invitedBy;
  int? classifiedPost;
  int? classifiedPostStatus;
  int? status;
  String? requestStatus;

  MyInvite({
    this.id,
    this.date,
    this.time,
    this.activity,
    this.location,
    this.invitedTo,
    this.invitedBy,
    this.classifiedPost,
    this.classifiedPostStatus,
    this.status,
    this.requestStatus,
  });

  factory MyInvite.fromJson(Map<String, dynamic> json) => MyInvite(
        id: json["id"],
        date: json["date"],
        time: json["time"],
        activity: json["activity"],
        location: json["location"],
        invitedTo: json["invited_to"] == null ? null : Invited.fromJson(json["invited_to"]),
        invitedBy: json["invited_by"] == null ? null : Invited.fromJson(json["invited_by"]),
        classifiedPost: json["classified_post"],
        classifiedPostStatus: json["classified_post_status"],
        status: json["status"],
        requestStatus: json["request_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "time": time,
        "activity": activity,
        "location": location,
        "invited_to": invitedTo?.toJson(),
        "invited_by": invitedBy?.toJson(),
        "classified_post": classifiedPost,
        "classified_post_status": classifiedPostStatus,
        "status": status,
        "request_status": requestStatusValues.reverse[requestStatus],
      };
}

class Invited {
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
  UserType? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  List<String>? interest;
  String? hobbies;
  String? gender;
  String? address;
  int? profileStatus;
  String? token;
  int? kyc;
  ActToken? actToken;
  double? totalReviewStar;
  int? onlineStatus;
  DateTime? createdAt;
  DateTime? updateAt;

  Invited({
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
    this.gender,
    this.address,
  });

  factory Invited.fromJson(Map<String, dynamic> json) => Invited(
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
        gender: json["gender"],
        address: json["address"],
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
        "user_type": userTypeValues.reverse[userType],
        "fcm_token": fcmToken,
        "verify_user": verifyUser,
        "phone_verify": phoneVerify,
        "Interest": interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
        "hobbies": hobbies,
        "gender": gender,
        "address": address,
        "profile_status": profileStatus,
        "token": token,
        "KYC": kyc,
        "act_token": actTokenValues.reverse[actToken],
        "Total_review_star": totalReviewStar,
        "online_status": onlineStatus,
        "created_at": createdAt?.toIso8601String(),
        "update_at": updateAt?.toIso8601String(),
      };
}

enum ActToken { EMPTY, F5_A_FN8_II }

final actTokenValues = EnumValues({"": ActToken.EMPTY, "F5aFN8II": ActToken.F5_A_FN8_II});

enum UserType { USER }

final userTypeValues = EnumValues({"user": UserType.USER});

enum RequestStatus { RECEIVED, REQUESTED }

final requestStatusValues = EnumValues({"Received": RequestStatus.RECEIVED, "Requested": RequestStatus.REQUESTED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
