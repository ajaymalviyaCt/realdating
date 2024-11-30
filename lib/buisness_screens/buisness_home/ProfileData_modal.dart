class ProfileDataModal {
  int? status;
  bool? success;
  String? message;
  BusinessInfo? businessInfo;

  ProfileDataModal({this.status, this.success, this.message, this.businessInfo});

  ProfileDataModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    businessInfo = json['business_info'] != null ? BusinessInfo.fromJson(json['business_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (businessInfo != null) {
      data['business_info'] = businessInfo!.toJson();
    }
    return data;
  }
}

class BusinessInfo {
  int? id;
  String? businessName;
  String? email;
  String? password;
  String? phoneNumber;
  int? kYC;
  var website;
  String? profileImage;
  var coverPhoto;
  String? showPassword;
  String? category;
  var instagramLink;
  var twitterLink;
  var facebookLink;
  var description;
  String? city;
  String? state;
  String? country;
  var address;
  var latitude;
  var longitude;
  int? verifyBusiness;
  String? actToken;
  String? createdAt;
  var token;
  int? monday;
  int? tuesday;
  int? wednesday;
  int? thursday;
  int? friday;
  int? saturday;
  int? sunday;

  BusinessInfo(
      {this.id,
      this.businessName,
      this.email,
      this.password,
      this.phoneNumber,
      this.kYC,
      this.website,
      this.profileImage,
      this.coverPhoto,
      this.showPassword,
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
      this.createdAt,
      this.token,
      this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  BusinessInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phone_number'];
    kYC = json['KYC'];
    website = json['website'];
    profileImage = json['profile_image'];
    coverPhoto = json['cover_photo'];
    showPassword = json['show_password'];
    category = json['category'];
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    facebookLink = json['facebook_link'];
    description = json['description'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    verifyBusiness = json['verify_business'];
    actToken = json['act_token'];
    createdAt = json['created_at'];
    token = json['token'];
    monday = json['Monday'];
    tuesday = json['Tuesday'];
    wednesday = json['Wednesday'];
    thursday = json['Thursday'];
    friday = json['Friday'];
    saturday = json['Saturday'];
    sunday = json['Sunday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['business_name'] = businessName;
    data['email'] = email;
    data['password'] = password;
    data['phone_number'] = phoneNumber;
    data['KYC'] = kYC;
    data['website'] = website;
    data['profile_image'] = profileImage;
    data['cover_photo'] = coverPhoto;
    data['show_password'] = showPassword;
    data['category'] = category;
    data['instagram_link'] = instagramLink;
    data['twitter_link'] = twitterLink;
    data['facebook_link'] = facebookLink;
    data['description'] = description;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['verify_business'] = verifyBusiness;
    data['act_token'] = actToken;
    data['created_at'] = createdAt;
    data['token'] = token;
    data['Monday'] = monday;
    data['Tuesday'] = tuesday;
    data['Wednesday'] = wednesday;
    data['Thursday'] = thursday;
    data['Friday'] = friday;
    data['Saturday'] = saturday;
    data['Sunday'] = sunday;
    return data;
  }
}
