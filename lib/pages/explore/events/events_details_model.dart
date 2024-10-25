// To parse this JSON data, do
//
//     final eventsDetailsModel = eventsDetailsModelFromJson(jsonString);

import 'dart:convert';

EventsDetailsModel eventsDetailsModelFromJson(String str) => EventsDetailsModel.fromJson(json.decode(str));

String eventsDetailsModelToJson(EventsDetailsModel data) => json.encode(data.toJson());

class EventsDetailsModel {
  bool success;
  String message;
  int status;
  List<GetEvent> getEvent;

  EventsDetailsModel({
    required this.success,
    required this.message,
    required this.status,
    required this.getEvent,
  });

  factory EventsDetailsModel.fromJson(Map<String, dynamic> json) => EventsDetailsModel(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    getEvent: List<GetEvent>.from(json["Get_event"].map((x) => GetEvent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "Get_event": List<dynamic>.from(getEvent.map((x) => x.toJson())),
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
