// To parse this JSON data, do
//
//     final getMyFriendRequestModel = getMyFriendRequestModelFromJson(jsonString);

import 'dart:convert';

GetMyFriendRequestModel getMyFriendRequestModelFromJson(String str) => GetMyFriendRequestModel.fromJson(json.decode(str));

String getMyFriendRequestModelToJson(GetMyFriendRequestModel data) => json.encode(data.toJson());

class GetMyFriendRequestModel {
  String? message;
  List<MyFriendsRequest>? myFriendsRequest;
  bool? success;
  int? status;

  GetMyFriendRequestModel({
    this.message,
    this.myFriendsRequest,
    this.success,
    this.status,
  });

  factory GetMyFriendRequestModel.fromJson(Map<String, dynamic> json) => GetMyFriendRequestModel(
    message: json["message"],
    myFriendsRequest: json["my_friends_request"] == null ? [] : List<MyFriendsRequest>.from(json["my_friends_request"]!.map((x) => MyFriendsRequest.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "my_friends_request": myFriendsRequest == null ? [] : List<dynamic>.from(myFriendsRequest!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class MyFriendsRequest {
  int? id;
  int? senderId;
  int? reciverId;
  int? status;
  DateTime? createdAt;
  List<SenderInfo>? senderInfo;

  MyFriendsRequest({
    this.id,
    this.senderId,
    this.reciverId,
    this.status,
    this.createdAt,
    this.senderInfo,
  });

  factory MyFriendsRequest.fromJson(Map<String, dynamic> json) => MyFriendsRequest(
    id: json["id"],
    senderId: json["sender_id"],
    reciverId: json["reciver_id"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    senderInfo: json["sender_info"] == null ? [] : List<SenderInfo>.from(json["sender_info"]!.map((x) => SenderInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sender_id": senderId,
    "reciver_id": reciverId,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "sender_info": senderInfo == null ? [] : List<dynamic>.from(senderInfo!.map((x) => x.toJson())),
  };
}

class SenderInfo {
  String? username;
  String? firstName;
  String? lastName;
  String? profileImage;

  SenderInfo({
    this.username,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory SenderInfo.fromJson(Map<String, dynamic> json) => SenderInfo(
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
  };
}
