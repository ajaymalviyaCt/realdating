import 'dart:convert';

GetAllAdsMdoels getAllAdsMdoelsFromJson(String str) => GetAllAdsMdoels.fromJson(json.decode(str));

String getAllAdsMdoelsToJson(GetAllAdsMdoels data) => json.encode(data.toJson());

class GetAllAdsMdoels {
  bool success;
  String message;
  int status;
  List<MyAdv> myAdvs;

  GetAllAdsMdoels({
    required this.success,
    required this.message,
    required this.status,
    required this.myAdvs,
  });

  factory GetAllAdsMdoels.fromJson(Map<String, dynamic> json) => GetAllAdsMdoels(
    success: json["success"],
    message: json["message"],
    status: json["status"],
    myAdvs: List<MyAdv>.from(json["My_advs"].map((x) => MyAdv.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "status": status,
    "My_advs": List<dynamic>.from(myAdvs.map((x) => x.toJson())),
  };
}

class MyAdv {
  int id;
  int businessId;
  int age;
  String title;
  String interest;
  int budget;
  String campaignDuration;
  String adImage;
  String address;
  String link;
  String? rangeKm;
  DateTime createdAt;
  DateTime updatedAt;

  MyAdv({
    required this.id,
    required this.businessId,
    required this.age,
    required this.title,
    required this.interest,
    required this.budget,
    required this.campaignDuration,
    required this.adImage,
    required this.address,
    required this.link,
     this.rangeKm,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyAdv.fromJson(Map<String, dynamic> json) => MyAdv(
    id: json["id"],
    businessId: json["business_id"],
    age: json["age"],
    title: json["title"],
    interest: json["interest"],
    budget: json["budget"],
    campaignDuration: json["campaign_duration"],
    adImage: json["ad_image"],
    address: json["address"],
    link: json["link"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    rangeKm: json["range_km"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "age": age,
    "title": title,
    "interest": interest,
    "budget": budget,
    "campaign_duration": campaignDuration,
    "ad_image": adImage,
    "address": address,
    "link": link,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}