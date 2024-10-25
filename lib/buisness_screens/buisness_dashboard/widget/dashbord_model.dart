// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool success;
  String message;
  int status;
  List<Dashboad> dashboad;

  DashboardModel({
    required this.success,
    required this.message,
    required this.status,
    required this.dashboad,
  });

  DashboardModel copyWith({
    bool? success,
    String? message,
    int? status,
    List<Dashboad>? dashboad,
  }) =>
      DashboardModel(
        success: success ?? this.success,
        message: message ?? this.message,
        status: status ?? this.status,
        dashboad: dashboad ?? this.dashboad,
      );

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    dashboad: List<Dashboad>.from(json["Dashboad"].map((x) => Dashboad.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "Dashboad": List<dynamic>.from(dashboad.map((x) => x.toJson())),
  };
}

class Dashboad {
  int id;
  int totalLike;
  int totalComment;
  int totalDeal;

  Dashboad({
    required this.id,
    required this.totalLike,
    required this.totalComment,
    required this.totalDeal,
  });

  Dashboad copyWith({
    int? id,
    int? totalLike,
    int? totalComment,
    int? totalDeal,
  }) =>
      Dashboad(
        id: id ?? this.id,
        totalLike: totalLike ?? this.totalLike,
        totalComment: totalComment ?? this.totalComment,
        totalDeal: totalDeal ?? this.totalDeal,
      );

  factory Dashboad.fromJson(Map<String, dynamic> json) => Dashboad(
    id: json["id"],
    totalLike: json["total_like"],
    totalComment: json["total_comment"],
    totalDeal: json["total_deal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_like": totalLike,
    "total_comment": totalComment,
    "total_deal": totalDeal,
  };
}
