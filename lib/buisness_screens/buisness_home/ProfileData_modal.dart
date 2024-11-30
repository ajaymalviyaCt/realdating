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
    businessInfo = json['business_info'] != null ? new BusinessInfo.fromJson(json['business_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.businessInfo != null) {
      data['business_info'] = this.businessInfo!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_number'] = this.phoneNumber;
    data['KYC'] = this.kYC;
    data['website'] = this.website;
    data['profile_image'] = this.profileImage;
    data['cover_photo'] = this.coverPhoto;
    data['show_password'] = this.showPassword;
    data['category'] = this.category;
    data['instagram_link'] = this.instagramLink;
    data['twitter_link'] = this.twitterLink;
    data['facebook_link'] = this.facebookLink;
    data['description'] = this.description;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['verify_business'] = this.verifyBusiness;
    data['act_token'] = this.actToken;
    data['created_at'] = this.createdAt;
    data['token'] = this.token;
    data['Monday'] = this.monday;
    data['Tuesday'] = this.tuesday;
    data['Wednesday'] = this.wednesday;
    data['Thursday'] = this.thursday;
    data['Friday'] = this.friday;
    data['Saturday'] = this.saturday;
    data['Sunday'] = this.sunday;
    return data;
  }
}
