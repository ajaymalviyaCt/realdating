// To parse this JSON data, do
//
//     final myDealsModel = myDealsModelFromJson(jsonString);

import 'dart:convert';

//////////////////// All Top Deal Model //////////////////////////

MyDealsModel myDealsModelFromJson(String str) => MyDealsModel.fromJson(json.decode(str));

String myDealsModelToJson(MyDealsModel data) => json.encode(data.toJson());

class MyDealsModel {
  bool success;
  String message;
  int status;
  List<MyDeal> myDeals;

  MyDealsModel({
    required this.success,
    required this.message,
    required this.status,
    required this.myDeals,
  });

  factory MyDealsModel.fromJson(Map<String, dynamic> json) => MyDealsModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        myDeals: List<MyDeal>.from(json["my_deals"].map((x) => MyDeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "my_deals": List<dynamic>.from(myDeals.map((x) => x.toJson())),
      };
}

class MyDeal {
  int id;
  int businessId;
  String title;
  int price;
  String discount;
  String roomImage;
  DateTime createdAt;
  DateTime updatedAt;

  MyDeal({
    required this.id,
    required this.businessId,
    required this.title,
    required this.price,
    required this.discount,
    required this.roomImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyDeal.fromJson(Map<String, dynamic> json) => MyDeal(
        id: json["id"],
        businessId: json["business_id"],
        title: json["Title"],
        price: json["Price"],
        discount: json["Discount"],
        roomImage: json["room_image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_id": businessId,
        "Title": title,
        "Price": price,
        "Discount": discount,
        "room_image": roomImage,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

/////////////// Edit Deal Model ////////////////////

EditUpdateModel editUpdateModelFromJson(String str) => EditUpdateModel.fromJson(json.decode(str));

String editUpdateModelToJson(EditUpdateModel data) => json.encode(data.toJson());

class EditUpdateModel {
  bool success;
  String message;
  int status;

  EditUpdateModel({required this.success, required this.message, required this.status});

  factory EditUpdateModel.fromJson(Map<String, dynamic> json) => EditUpdateModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
      };
}
