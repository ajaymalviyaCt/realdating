// To parse this JSON data, do
//
//     final exploreDetailsModel = exploreDetailsModelFromJson(jsonString);

import 'dart:convert';

ExploreDetailsModel exploreDetailsModelFromJson(String str) => ExploreDetailsModel.fromJson(json.decode(str));

String exploreDetailsModelToJson(ExploreDetailsModel data) => json.encode(data.toJson());

class ExploreDetailsModel {
  bool success;
  String message;
  int status;
  List<UserInfo> userInfo;

  ExploreDetailsModel({
    required this.success,
    required this.message,
    required this.status,
    required this.userInfo,
  });

  factory ExploreDetailsModel.fromJson(Map<String, dynamic> json) => ExploreDetailsModel(
        success: json["success"],
        message: json["message"],
        status: json["status"],
        userInfo: List<UserInfo>.from(json["user_info"].map((x) => UserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "status": status,
        "user_info": List<dynamic>.from(userInfo.map((x) => x.toJson())),
      };
}

class UserInfo {
  int id;
  String firstName;
  String lastName;
  String profileImage;
  String username;
  String email;
  String password;
  String showPassword;
  String phoneNumber;
  int otp;
  int? age;
  int trending;
  String dob;
  String height;
  String userType;
  String fcmToken;
  int verifyUser;
  int phoneVerify;
  String interest;
  String hobbies;
  String gender;
  String address;
  String logitude;
  String latitude;
  String proplan;
  int profileStatus;
  String token;
  int kyc;
  String actToken;
  var totalReviewStar;
  int onlineStatus;
  DateTime createdAt;
  DateTime updateAt;
  List<String> insertdata;
  List<String> hobbiesdata;
  int reviewCount;
  List<AllReview> allReviews;
  List<Image> images;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.username,
    required this.email,
    required this.password,
    required this.showPassword,
    required this.phoneNumber,
    required this.otp,
    required this.age,
    required this.trending,
    required this.dob,
    required this.height,
    required this.userType,
    required this.fcmToken,
    required this.verifyUser,
    required this.phoneVerify,
    required this.interest,
    required this.hobbies,
    required this.gender,
    required this.address,
    required this.logitude,
    required this.latitude,
    required this.proplan,
    required this.profileStatus,
    required this.token,
    required this.kyc,
    required this.actToken,
    required this.totalReviewStar,
    required this.onlineStatus,
    required this.createdAt,
    required this.updateAt,
    required this.insertdata,
    required this.hobbiesdata,
    required this.reviewCount,
    required this.allReviews,
    required this.images,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        showPassword: json["show_password"],
        phoneNumber: json["phone_number"],
        otp: json["OTP"],
        age: json["age"],
        trending: json["trending"],
        dob: json["DOB"],
        height: json["height"],
        userType: json["user_type"],
        fcmToken: json["fcm_token"],
        verifyUser: json["verify_user"],
        phoneVerify: json["phone_verify"],
        interest: json["Interest"],
        hobbies: json["hobbies"],
        gender: json["gender"],
        address: json["address"],
        logitude: json["logitude"],
        latitude: json["latitude"],
        proplan: json["pro_plan"],
        profileStatus: json["profile_status"],
        token: json["token"],
        kyc: json["KYC"],
        actToken: json["act_token"],
        totalReviewStar: json["Total_review_star"],
        onlineStatus: json["online_status"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["updated_at"]),
        insertdata: List<String>.from(json["insertdata"].map((x) => x)),
        hobbiesdata: List<String>.from(json["hobbiesdata"].map((x) => x)),
        reviewCount: json["review_count"],
        allReviews: List<AllReview>.from(json["all_reviews"].map((x) => AllReview.fromJson(x))),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
        "username": username,
        "email": email,
        "password": password,
        "show_password": showPassword,
        "phone_number": phoneNumber,
        "OTP": otp,
        "age": age,
        "trending": trending,
        "DOB": dob,
        "height": height,
        "user_type": userType,
        "fcm_token": fcmToken,
        "verify_user": verifyUser,
        "phone_verify": phoneVerify,
        "Interest": interest,
        "hobbies": hobbies,
        "gender": gender,
        "address": address,
        "logitude": logitude,
        "latitude": latitude,
        "pro_plan": proplan,
        "profile_status": profileStatus,
        "token": token,
        "KYC": kyc,
        "act_token": actToken,
        "Total_review_star": totalReviewStar,
        "online_status": onlineStatus,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "insertdata": List<dynamic>.from(insertdata.map((x) => x)),
        "hobbiesdata": List<dynamic>.from(hobbiesdata.map((x) => x)),
        "review_count": reviewCount,
        "all_reviews": List<dynamic>.from(allReviews.map((x) => x.toJson())),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
      };
}

class AllReview {
  int id;
  int userId;
  String review;
  int ratingStar;
  int reviewBy;
  DateTime createdAt;
  String reviewerUsername;
  String reviewerProfileImage;

  AllReview({
    required this.id,
    required this.userId,
    required this.review,
    required this.ratingStar,
    required this.reviewBy,
    required this.createdAt,
    required this.reviewerUsername,
    required this.reviewerProfileImage,
  });

  factory AllReview.fromJson(Map<String, dynamic> json) => AllReview(
        id: json["id"],
        userId: json["user_id"],
        review: json["review"],
        ratingStar: json["rating_star"],
        reviewBy: json["review_by"],
        createdAt: DateTime.parse(json["created_at"]),
        reviewerUsername: json["reviewer_username"],
        reviewerProfileImage: json["reviewer_profile_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "review": review,
        "rating_star": ratingStar,
        "review_by": reviewBy,
        "created_at": createdAt.toIso8601String(),
        "reviewer_username": reviewerUsername,
        "reviewer_profile_image": reviewerProfileImage,
      };
}

class Image {
  String profileImages;

  Image({
    required this.profileImages,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        profileImages: json["profile_images"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "profile_images": profileImages,
      };
}
