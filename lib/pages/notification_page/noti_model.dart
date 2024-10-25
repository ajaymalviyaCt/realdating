// To parse this JSON data, do
//
//     final noficactionModel = noficactionModelFromJson(jsonString);

import 'dart:convert';

NoficactionModel noficactionModelFromJson(String str) => NoficactionModel.fromJson(json.decode(str));

String noficactionModelToJson(NoficactionModel data) => json.encode(data.toJson());

class NoficactionModel {
  bool? success;
  String? message;
  List<Notification>? notification;
  int status;

  NoficactionModel({
    this.success,
    this.message,
    this.notification,
    required this.status,
  });

  factory NoficactionModel.fromJson(Map<String, dynamic> json) => NoficactionModel(
    success: json["success"],
    message: json["message"],
    notification: json["notification"] == null ? [] : List<Notification>.from(json["notification"]!.map((x) => Notification.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "notification": notification == null ? [] : List<dynamic>.from(notification!.map((x) => x.toJson())),
    "status": status,
  };
}

class Notification {
  int? id;
  int? userId;
  String? body;
  String? notificationType;
  int? senderId;
  int? reciverId;
  DateTime? createdAt;
  int? friendRequestStatus;
  String? senderFirstName;
  String? senderLastName;
  String? profileImage;

  Notification({
    this.id,
    this.userId,
    this.body,
    this.notificationType,
    this.senderId,
    this.reciverId,
    this.createdAt,
    this.friendRequestStatus,
    this.senderFirstName,
    this.senderLastName,
    this.profileImage,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    userId: json["user_id"],
    body: json["body"],
    notificationType: json["notification_type"],
    senderId: json["sender_id"],
    reciverId: json["reciver_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    friendRequestStatus: json["friend_request_status"],
    senderFirstName: json["sender_first_name"],
    senderLastName: json["sender_last_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "body": body,
    "notification_type": notificationType,
    "sender_id": senderId,
    "reciver_id": reciverId,
    "created_at": createdAt?.toIso8601String(),
    "friend_request_status": friendRequestStatus,
    "sender_first_name": senderFirstName,
    "sender_last_name": senderLastName,
    "profile_image": profileImage,
  };
}
