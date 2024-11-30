// To parse this JSON data, do
//
//     final getAllUserModel = getAllUserModelFromJson(jsonString);

import 'dart:convert';

GetAllUserModel getAllUserModelFromJson(String str) => GetAllUserModel.fromJson(json.decode(str));

String getAllUserModelToJson(GetAllUserModel data) => json.encode(data.toJson());

class GetAllUserModel {
  String? message;
  List<MyFriendSwipe>? myFriends;
  bool? success;
  int? status;

  GetAllUserModel({
    this.message,
    this.myFriends,
    this.success,
    this.status,
  });

  factory GetAllUserModel.fromJson(Map<String, dynamic> json) => GetAllUserModel(
        message: json["message"],
        myFriends: json["my_friends"] == null ? [] : List<MyFriendSwipe>.from(json["my_friends"]!.map((x) => MyFriendSwipe.fromJson(x))),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "my_friends": myFriends == null ? [] : List<dynamic>.from(myFriends!.map((x) => x.toJson())),
        "success": success,
        "status": status,
      };
}

class MyFriendSwipe {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? username;
  String? email;
  String? password;
  dynamic age;
  String? gender;

  MyFriendSwipe({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.username,
    this.age,
    this.gender,
  });

  factory MyFriendSwipe.fromJson(Map<String, dynamic> json) => MyFriendSwipe(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
        username: json["username"],
        age: json["age"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
        "username": username,
        "email": email,
        "password": password,
        "age": age,
        "gender": gender,
      };
}
