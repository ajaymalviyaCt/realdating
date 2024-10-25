// To parse this JSON data, do
//
//     final mapeBusinessModel = mapeBusinessModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MapeBusinessModel mapeBusinessModelFromJson(String str) => MapeBusinessModel.fromJson(json.decode(str));

String mapeBusinessModelToJson(MapeBusinessModel data) => json.encode(data.toJson());

class MapeBusinessModel {
  final String message;
  final bool success;
  final List<Bussiness> bussiness;
  final int status;

  MapeBusinessModel({
    required this.message,
    required this.success,
    required this.bussiness,
    required this.status,
  });

  factory MapeBusinessModel.fromJson(Map<String, dynamic> json) => MapeBusinessModel(
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
  final int id;
  final String businessName;
  final String email;
  final String password;
  final String phoneNumber;
  final int kyc;
  final String website;
  final String profileImage;
  final String coverPhoto;
  final String showPassword;
  final String category;
  final String instagramLink;
  final String twitterLink;
  final String facebookLink;
  final String description;
  final String city;
  final String state;
  final String country;
  final String address;
  final String latitude;
  final String longitude;
  final int verifyBusiness;
  final String actToken;
  final DateTime createdAt;
  final String token;

  Bussiness({
    required this.id,
    required this.businessName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.kyc,
    required this.website,
    required this.profileImage,
    required this.coverPhoto,
    required this.showPassword,
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
    required this.createdAt,
    required this.token,
  });

  factory Bussiness.fromJson(Map<String, dynamic> json) => Bussiness(
    id: json["id"],
    businessName: json["business_name"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phone_number"],
    kyc: json["KYC"],
    website: json["website"]??"",
    profileImage: json["profile_image"],
    coverPhoto: json["cover_photo"]??"",
    showPassword: json["show_password"],
    category: json["category"],
    instagramLink: json["instagram_link"]??"",
    twitterLink: json["twitter_link"]??"",
    facebookLink: json["facebook_link"]??"",
    description: json["description"]??"",
    city: json["city"],
    state: json["state"],
    country: json["country"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    verifyBusiness: json["verify_business"],
    actToken: json["act_token"],
    createdAt: DateTime.parse(json["created_at"]),
    token: json["token"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_name": businessName,
    "email": email,
    "password": password,
    "phone_number": phoneNumber,
    "KYC": kyc,
    "website": website,
    "profile_image": profileImage,
    "cover_photo": coverPhoto,
    "show_password": showPassword,
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
    "created_at": createdAt.toIso8601String(),
    "token": token,
  };
}
