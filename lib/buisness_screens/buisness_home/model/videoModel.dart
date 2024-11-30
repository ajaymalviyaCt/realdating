// To parse this JSON data, do
//
//     final businessHomeVideoModel = businessHomeVideoModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BusinessHomeVideoModel businessHomeVideoModelFromJson(String str) => BusinessHomeVideoModel.fromJson(json.decode(str));

String businessHomeVideoModelToJson(BusinessHomeVideoModel data) => json.encode(data.toJson());

class BusinessHomeVideoModel {
  bool success;
  String message;
  int status;
  List<AllVideoLink> allVideoLinks;

  BusinessHomeVideoModel({
    required this.success,
    required this.message,
    required this.status,
    required this.allVideoLinks,
  });

  BusinessHomeVideoModel copyWith({
    bool? success,
    String? message,
    int? status,
    List<AllVideoLink>? allVideoLinks,
  }) =>
      BusinessHomeVideoModel(
        success: success ?? this.success,
        message: message ?? this.message,
        status: status ?? this.status,
        allVideoLinks: allVideoLinks ?? this.allVideoLinks,
      );

  factory BusinessHomeVideoModel.fromJson(Map<String, dynamic> json) => BusinessHomeVideoModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        allVideoLinks: List<AllVideoLink>.from(json["ALL_video_Links"].map((x) => AllVideoLink.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "ALL_video_Links": List<dynamic>.from(allVideoLinks.map((x) => x.toJson())),
      };
}

class AllVideoLink {
  String videoLinks;

  AllVideoLink({
    required this.videoLinks,
  });

  AllVideoLink copyWith({
    String? videoLinks,
  }) =>
      AllVideoLink(
        videoLinks: videoLinks ?? this.videoLinks,
      );

  factory AllVideoLink.fromJson(Map<String, dynamic> json) => AllVideoLink(
        videoLinks: json["video_links"],
      );

  Map<String, dynamic> toJson() => {
        "video_links": videoLinks,
      };
}
