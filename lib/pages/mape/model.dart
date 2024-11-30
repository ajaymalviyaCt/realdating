// To parse this JSON data, do
//
//     final getNearByBusinessListModel = getNearByBusinessListModelFromJson(jsonString);

import 'dart:convert';

GetNearByBusinessListModel getNearByBusinessListModelFromJson(String str) => GetNearByBusinessListModel.fromJson(json.decode(str));

String getNearByBusinessListModelToJson(GetNearByBusinessListModel data) => json.encode(data.toJson());

class GetNearByBusinessListModel {
  String message;
  bool success;
  List<Bussiness> bussiness;
  int status;

  GetNearByBusinessListModel({
    required this.message,
    required this.success,
    required this.bussiness,
    required this.status,
  });

  factory GetNearByBusinessListModel.fromJson(Map<String, dynamic> json) => GetNearByBusinessListModel(
        message: json["message"],
        success: json["success"],
        bussiness: List<Bussiness>.from(json["bussiness"].map((x) => Bussiness.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "bussiness": List<dynamic>.from(bussiness.map((x) => x.toJson())),
        "status": status,
      };
}

class Bussiness {
  int id;
  String businessName;
  String email;
  String password;
  String showPassword;
  String phoneNumber;
  String? fcmToken;
  int kyc;
  String? website;
  String profileImage;
  String? coverPhoto;
  String category;
  String? instagramLink;
  String? twitterLink;
  String? facebookLink;
  String? description;
  String city;
  String state;
  String country;
  String address;
  String latitude;
  String longitude;
  int verifyBusiness;
  String? actToken;
  String? token;
  DateTime createdAt;
  DateTime? updatedAt;
  List<dynamic>? deals;
  List<AllDeal>? allDeals;

  Bussiness({
    required this.id,
    required this.businessName,
    required this.email,
    required this.password,
    required this.showPassword,
    required this.phoneNumber,
    required this.fcmToken,
    required this.kyc,
    required this.website,
    required this.profileImage,
    required this.coverPhoto,
    required this.category,
    required this.instagramLink,
    required this.twitterLink,
    required this.facebookLink,
    required this.description,
    required this.city,
    required this.state,
    required this.country,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.verifyBusiness,
    required this.actToken,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    this.deals,
    this.allDeals,
  });

  factory Bussiness.fromJson(Map<String, dynamic> json) => Bussiness(
        id: json["id"],
        businessName: json["business_name"],
        email: json["email"],
        password: json["password"],
        showPassword: json["show_password"],
        phoneNumber: json["phone_number"],
        fcmToken: json["fcm_token"],
        kyc: json["KYC"],
        website: json["website"],
        profileImage: json["profile_image"],
        coverPhoto: json["cover_photo"],
        category: json["category"],
        instagramLink: json["instagram_link"],
        twitterLink: json["twitter_link"],
        facebookLink: json["facebook_link"],
        description: json["description"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        verifyBusiness: json["verify_business"],
        actToken: json["act_token"],
        token: json["token"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deals: json["deals"] == null ? [] : List<dynamic>.from(json["deals"]!.map((x) => x)),
        allDeals: json["allDeals"] == null ? [] : List<AllDeal>.from(json["allDeals"]!.map((x) => AllDeal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "business_name": businessName,
        "email": email,
        "password": password,
        "show_password": showPassword,
        "phone_number": phoneNumber,
        "fcm_token": fcmToken,
        "KYC": kyc,
        "website": website,
        "profile_image": profileImage,
        "cover_photo": coverPhoto,
        "category": category,
        "instagram_link": instagramLink,
        "twitter_link": twitterLink,
        "facebook_link": facebookLink,
        "description": description,
        "city": city,
        "state": state,
        "country": country,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "verify_business": verifyBusiness,
        "act_token": actToken,
        "token": token,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deals": deals == null ? [] : List<dynamic>.from(deals!.map((x) => x)),
        "allDeals": allDeals == null ? [] : List<dynamic>.from(allDeals!.map((x) => x.toJson())),
      };
}

class AllDeal {
  int id;
  int businessId;
  String title;
  int price;
  String discount;
  String roomImage;
  int topDeals;
  DateTime createdAt;
  DateTime updatedAt;

  AllDeal({
    required this.id,
    required this.businessId,
    required this.title,
    required this.price,
    required this.discount,
    required this.roomImage,
    required this.topDeals,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllDeal.fromJson(Map<String, dynamic> json) => AllDeal(
        id: json["id"],
        businessId: json["business_id"],
        title: json["Title"],
        price: json["Price"],
        discount: json["Discount"],
        roomImage: json["room_image"],
        topDeals: json["top_deals"],
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
        "top_deals": topDeals,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
