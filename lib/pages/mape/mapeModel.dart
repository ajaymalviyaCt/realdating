import 'dart:convert';

class MapeBusinessModel {
  String? message;
  bool? success;
  List<Bussiness>? bussiness;
  num?status;

  MapeBusinessModel({
    this.message,
    this.success,
    this.bussiness,
    this.status,
  });

  factory MapeBusinessModel.fromRawJson(String str) => MapeBusinessModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapeBusinessModel.fromJson(Map<String, dynamic> json) => MapeBusinessModel(
    message: json["message"],
    success: json["success"],
    bussiness: json["bussiness"] == null ? [] : List<Bussiness>.from(json["bussiness"]!.map((x) => Bussiness.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "bussiness": bussiness == null ? [] : List<dynamic>.from(bussiness!.map((x) => x.toJson())),
    "status": status,
  };
}

class Bussiness {
  num?id;
  String? businessName;
  String? email;
  String? password;
  String? showPassword;
  String? phoneNumber;
  String? fcmToken;
  num?kyc;
  String? website;
  String? profileImage;
  String? coverPhoto;
  String? category;
  String? instagramLink;
  String? twitterLink;
  String? facebookLink;
  String? description;
  String? city;
  String? state;
  String? country;
  String? address;
  String? latitude;
  String? longitude;
  num?verifyBusiness;
  String? actToken;
  String? token;
  String? createdAt;
  String? updatedAt;
  List<AllDeal>? allDeals;

  Bussiness({
    this.id,
    this.businessName,
    this.email,
    this.password,
    this.showPassword,
    this.phoneNumber,
    this.fcmToken,
    this.kyc,
    this.website,
    this.profileImage,
    this.coverPhoto,
    this.category,
    this.instagramLink,
    this.twitterLink,
    this.facebookLink,
    this.description,
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
    this.allDeals,
  });

  factory Bussiness.fromRawJson(String str) => Bussiness.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
    "allDeals": allDeals == null ? [] : List<dynamic>.from(allDeals!.map((x) => x.toJson())),
  };
}

class AllDeal {
  num?id;
  num?businessId;
  String? title;
  num?price;
  String? discount;
  String? roomImage;
  num?topDeals;
  String? createdAt;
  String? updatedAt;

  AllDeal({
    this.id,
    this.businessId,
    this.title,
    this.price,
    this.discount,
    this.roomImage,
    this.topDeals,
    this.createdAt,
    this.updatedAt,
  });

  factory AllDeal.fromRawJson(String str) => AllDeal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AllDeal.fromJson(Map<String, dynamic> json) => AllDeal(
    id: json["id"],
    businessId: json["business_id"],
    title: json["Title"],
    price: json["Price"],
    discount: json["Discount"],
    roomImage: json["room_image"],
    topDeals: json["top_deals"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "business_id": businessId,
    "Title": title,
    "Price": price,
    "Discount": discount,
    "room_image": roomImage,
    "top_deals": topDeals,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
