// To parse this JSON data, do
//
//     final pollsModel = pollsModelFromJson(jsonString);

import 'dart:convert';

PollsModel pollsModelFromJson(String str) => PollsModel.fromJson(json.decode(str));

String pollsModelToJson(PollsModel data) => json.encode(data.toJson());

class PollsModel {
  bool? success;
  String? message;
  Polls? polls;
  int? status;

  PollsModel({
    this.success,
    this.message,
    this.polls,
    this.status,
  });

  factory PollsModel.fromJson(Map<String, dynamic> json) => PollsModel(
    success: json["success"],
    message: json["message"],
    polls: json["polls"] == null ? null : Polls.fromJson(json["polls"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "polls": polls?.toJson(),
    "status": status,
  };
}

class Polls {
  int? id;
  int? userId;
  String? poll;
  int? status;
  String? pollOption1;
  String? pollOption2;
  String? pollOption3;
  int? pollOption1Count;
  int? pollOption2Count;
  int? pollOption3Count;
  DateTime? createdAt;
  int? isVoted;
  List<Response>? response;
  String? ownerFirstName;
  String? ownerLastName;
  String? profileImage;

  Polls({
    this.id,
    this.userId,
    this.poll,
    this.status,
    this.pollOption1,
    this.pollOption2,
    this.pollOption3,
    this.pollOption1Count,
    this.pollOption2Count,
    this.pollOption3Count,
    this.createdAt,
    this.isVoted,
    this.response,
    this.ownerFirstName,
    this.ownerLastName,
    this.profileImage,
  });

  factory Polls.fromJson(Map<String, dynamic> json) => Polls(
    id: json["id"],
    userId: json["user_id"],
    poll: json["poll"],
    status: json["status"],
    pollOption1: json["poll_option_1"],
    pollOption2: json["poll_option_2"],
    pollOption3: json["poll_option_3"],
    pollOption1Count: json["poll_option_1_count"],
    pollOption2Count: json["poll_option_2_count"],
    pollOption3Count: json["poll_option_3_count"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isVoted: json["is_voted"],
    response: json["response"] == null ? [] : List<Response>.from(json["response"]!.map((x) => Response.fromJson(x))),
    ownerFirstName: json["owner_first_name"],
    ownerLastName: json["owner_last_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "poll": poll,
    "status": status,
    "poll_option_1": pollOption1,
    "poll_option_2": pollOption2,
    "poll_option_3": pollOption3,
    "poll_option_1_count": pollOption1Count,
    "poll_option_2_count": pollOption2Count,
    "poll_option_3_count": pollOption3Count,
    "created_at": createdAt?.toIso8601String(),
    "is_voted": isVoted,
    "response": response == null ? [] : List<dynamic>.from(response!.map((x) => x.toJson())),
    "owner_first_name": ownerFirstName,
    "owner_last_name": ownerLastName,
    "profile_image": profileImage,
  };
}

class Response {
  int? id;
  int? pollId;
  int? userId;
  int? pollOption1;
  int? pollOption2;
  int? pollOption3;
  DateTime? createdAt;
  int? ownerId;
  String? firstName;
  String? lastName;
  String? profileImage;

  Response({
    this.id,
    this.pollId,
    this.userId,
    this.pollOption1,
    this.pollOption2,
    this.pollOption3,
    this.createdAt,
    this.ownerId,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    id: json["id"],
    pollId: json["poll_id"],
    userId: json["user_id"],
    pollOption1: json["poll_option_1"],
    pollOption2: json["poll_option_2"],
    pollOption3: json["poll_option_3"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    ownerId: json["owner_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "poll_id": pollId,
    "user_id": userId,
    "poll_option_1": pollOption1,
    "poll_option_2": pollOption2,
    "poll_option_3": pollOption3,
    "created_at": createdAt?.toIso8601String(),
    "owner_id": ownerId,
    "first_name": firstName,
    "last_name": lastName,
    "profile_image": profileImage,
  };
}
