// To parse this JSON data, do
//
//     final eventssModel = eventssModelFromJson(jsonString);

import 'dart:convert';

EventssModel eventssModelFromJson(String str) => EventssModel.fromJson(json.decode(str));

String eventssModelToJson(EventssModel data) => json.encode(data.toJson());

class EventssModel {
  bool success;
  String message;
  int status;
  List<GetEvent> getEvents;

  EventssModel({
    required this.success,
    required this.message,
    required this.status,
    required this.getEvents,
  });

  factory EventssModel.fromJson(Map<String, dynamic> json) => EventssModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        getEvents: List<GetEvent>.from(json["Get_events"].map((x) => GetEvent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "Get_events": List<dynamic>.from(getEvents.map((x) => x.toJson())),
      };
}

class GetEvent {
  int id;
  String eventTitle;
  String eventType;
  String startDate;
  String endDate;
  String selectTime;
  String eventImage;
  DateTime createdAt;
  String description;
  DateTime updatedAt;

  GetEvent({
    required this.id,
    required this.eventTitle,
    required this.eventType,
    required this.startDate,
    required this.endDate,
    required this.selectTime,
    required this.eventImage,
    required this.createdAt,
    required this.description,
    required this.updatedAt,
  });

  factory GetEvent.fromJson(Map<String, dynamic> json) => GetEvent(
        id: json["id"],
        eventTitle: json["Event_Title"],
        eventType: json["Event_Type"],
        startDate: json["Start_Date"],
        endDate: json["End_Date"],
        selectTime: json["Select_Time"],
        eventImage: json["Event_image"],
        createdAt: DateTime.parse(json["created_at"]),
        description: json["Description"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Event_Title": eventTitle,
        "Event_Type": eventType,
        "Start_Date": startDate,
        "End_Date": endDate,
        "Select_Time": selectTime,
        "Event_image": eventImage,
        "created_at": createdAt.toIso8601String(),
        "Description": description,
        "updated_at": updatedAt.toIso8601String(),
      };
}
