// To parse this JSON data, do
//
//     final myProfileModel = myProfileModelFromJson(jsonString);

import 'dart:convert';

MyProfileModel myProfileModelFromJson(String str) => MyProfileModel.fromJson(json.decode(str));

String myProfileModelToJson(MyProfileModel data) => json.encode(data.toJson());

class MyProfileModel {
  int? status;
  bool? success;
  String? message;
  BusinessInfo? businessInfo;

  MyProfileModel({
    this.status,
    this.success,
    this.message,
    this.businessInfo,
  });

  factory MyProfileModel.fromJson(Map<String, dynamic> json) => MyProfileModel(
    status: json["status"],
    success: json["success"],
    message: json["message"],
    businessInfo: json["business_info"] == null ? null : BusinessInfo.fromJson(json["business_info"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "message": message,
    "business_info": businessInfo?.toJson(),
  };
}

class BusinessInfo {
  int? id;
  String? businessName;
  String? email;
  String? password;
  String? showPassword;
  String phoneNumber;
  String? fcmToken;
  int? kyc;
  String website;
  String? profileImage;
  String? coverPhoto;
  String category;
  String  instagramLink;
  String twitterLink;
  String  facebookLink;
  String  description;
  String? city;
  String? state;
  String? country;
  String? address;
  String? latitude;
  String? longitude;
  int? verifyBusiness;
  String? actToken;
  String? token;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  int? sunday;

  BusinessInfo({
    this.id,
    this.businessName,
    this.email,
    this.password,
    this.showPassword,
    required this.phoneNumber,
    this.fcmToken,
    this.kyc,
    required this.website,
    this.profileImage,
    this.coverPhoto,
    required this.category,
    required this.instagramLink,
    required this.twitterLink,
    required this.facebookLink,
    required this.description,
    this.city,
    this.state,
    this.country,
    this.address,
    this.latitude,
    this.longitude,
    this.verifyBusiness,
    this.actToken,
    this.token,
    this.createdAt,
    this.updatedAt,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  factory BusinessInfo.fromJson(Map<String, dynamic> json) => BusinessInfo(
    id: json["id"],
    businessName: json["business_name"],
    email: json["email"],
    password: json["password"],
    showPassword: json["show_password"],
    phoneNumber: json["phone_number"] ?? 0,
    fcmToken: json["fcm_token"],
    kyc: json["KYC"],
    website: json["website"] ?? "",
    profileImage: json["profile_image"],
    coverPhoto: json["cover_photo"] ?? '',
    category: json["category"] ??'',
    instagramLink: json["instagram_link"] ?? '',
    twitterLink: json["twitter_link"] ?? '',
    facebookLink: json["facebook_link"] ??"",
    description: json["description"] ?? '',
    city: json["city"],
    state: json["state"],
    country: json["country"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    verifyBusiness: json["verify_business"],
    actToken: json["act_token"],
    token: json["token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    monday: json["Monday"],
    tuesday: json["Tuesday"],
    wednesday: json["Wednesday"],
    thursday: json["Thursday"],
    friday: json["Friday"],
    saturday: json["Saturday"],
    sunday: json["Sunday"],
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "Monday": monday,
    "Tuesday": tuesday,
    "Wednesday": wednesday,
    "Thursday": thursday,
    "Friday": friday,
    "Saturday": saturday,
    "Sunday": sunday,
  };
}
