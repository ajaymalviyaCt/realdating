class PostUserModel {
  bool? success;
  String? message;
  int? status;
  List<UserPosts>? posts;

  PostUserModel({this.success, this.message, this.status, this.posts});

  PostUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    if (json['posts'] != null) {
      posts = <UserPosts>[];
      json['posts'].forEach((v) {
        posts!.add(UserPosts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPosts {
  int? id;
  String? userId;
  String? postName;
  String? post;
  String? postType;
  String? miniblogs;
  String? caption;
  String? createdAt;
  int? totalComments;
  int? totalLikes;
  String? updatedAt;
  List<MentionsData>? mentionsData;
  String? likedByUser;
  List<PostOwnerInfo>? postOwnerInfo;
  List<Comments>? comments;
  int? aD;
  var businessId;
  var age;
  String? title;
  String? interest;
  var budget;
  String? campaignDuration;
  String? adImage;
  String? address;
  String? link;
  String? rangeKm;

  UserPosts(
      {this.id,
      this.userId,
      this.postName,
      this.post,
      this.postType,
      this.miniblogs,
      this.caption,
      this.createdAt,
      this.totalComments,
      this.totalLikes,
      this.updatedAt,
      this.mentionsData,
      this.likedByUser,
      this.postOwnerInfo,
      this.comments,
      this.aD,
      this.businessId,
      this.age,
      this.title,
      this.interest,
      this.budget,
      this.campaignDuration,
      this.adImage,
      this.address,
      this.link,
      this.rangeKm});

  UserPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    totalComments = json["total_comments"];
    totalLikes = json["total_likes"];
    postName = json['post_name'];
    post = json['post'];
    postType = json["post_type"];
    miniblogs = json['miniblogs'];
    caption = json['caption'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['mentions_data'] != null) {
      mentionsData = <MentionsData>[];
      json['mentions_data'].forEach((v) {
        mentionsData!.add(new MentionsData.fromJson(v));
      });
    }
    likedByUser = json['liked_by_user'];
    if (json['post_owner_info'] != null) {
      postOwnerInfo = <PostOwnerInfo>[];
      json['post_owner_info'].forEach((v) {
        postOwnerInfo!.add(PostOwnerInfo.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(Comments.fromJson(v));
      });
    }
    aD = json['AD'];
    businessId = json['business_id'] ?? "";
    age = json['age'] ?? "";
    title = json['title'] ?? "";
    interest = json['interest'] ?? "";
    budget = json['budget'] ?? "";
    campaignDuration = json['campaign_duration'] ?? "";
    adImage = json['ad_image'] ?? "";
    address = json['address'] ?? "";
    link = json['link'] ?? "";
    rangeKm = json['range_km'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['post_name'] = this.postName;
    data['post'] = this.post;
    data['total_comments'] = this.totalComments;
    data['total_likes'] = this.totalLikes;

    data['miniblogs'] = this.miniblogs;
    data['caption'] = this.caption;
    data['created_at'] = this.createdAt;

    data['updated_at'] = this.updatedAt;
    if (this.mentionsData != null) {
      data['mentions_data'] = this.mentionsData!.map((v) => v.toJson()).toList();
    }
    data['liked_by_user'] = this.likedByUser;
    if (this.postOwnerInfo != null) {
      data['post_owner_info'] = this.postOwnerInfo!.map((v) => v.toJson()).toList();
    }
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['AD'] = this.aD;
    data['business_id'] = this.businessId;
    data['age'] = this.age;
    data['title'] = this.title;
    data['interest'] = this.interest;
    data['budget'] = this.budget;
    data['campaign_duration'] = this.campaignDuration;
    data['ad_image'] = this.adImage;
    data['address'] = this.address;
    data['link'] = this.link;
    data['range_km'] = this.rangeKm;
    return data;
  }
}

class MentionsData {
  int? id;
  String? firstName;
  String? lastName;
  String? profileImage;
  String? username;
  String? email;
  String? password;
  String? showPassword;
  String? phoneNumber;
  int? oTP;
  int? age;
  int? trending;
  String? dOB;
  String? height;
  String? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  String? interest;
  String? hobbies;
  String? gender;
  String? address;
  String? logitude;
  String? latitude;
  int? profileStatus;
  String? token;
  int? kYC;
  String? actToken;
  var totalReviewStar;
  int? onlineStatus;
  String? createdAt;
  String? updateAt;

  MentionsData(
      {this.id,
      this.firstName,
      this.lastName,
      this.profileImage,
      this.username,
      this.email,
      this.password,
      this.showPassword,
      this.phoneNumber,
      this.oTP,
      this.age,
      this.trending,
      this.dOB,
      this.height,
      this.userType,
      this.fcmToken,
      this.verifyUser,
      this.phoneVerify,
      this.interest,
      this.hobbies,
      this.gender,
      this.address,
      this.logitude,
      this.latitude,
      this.profileStatus,
      this.token,
      this.kYC,
      this.actToken,
      this.totalReviewStar,
      this.onlineStatus,
      this.createdAt,
      this.updateAt});

  MentionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    showPassword = json['show_password'];
    phoneNumber = json['phone_number'];
    oTP = json['OTP'];
    age = json['age'];
    trending = json['trending'];
    dOB = json['DOB'];
    height = json['height'];
    userType = json['user_type'];
    fcmToken = json['fcm_token'];
    verifyUser = json['verify_user'];
    phoneVerify = json['phone_verify'];
    interest = json['Interest'];
    hobbies = json['hobbies'];
    gender = json['gender'];
    address = json['address'];
    logitude = json['logitude'];
    latitude = json['latitude'];
    profileStatus = json['profile_status'];
    token = json['token'];
    kYC = json['KYC'];
    actToken = json['act_token'];
    totalReviewStar = json['Total_review_star'];
    onlineStatus = json['online_status'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['profile_image'] = this.profileImage;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['show_password'] = this.showPassword;
    data['phone_number'] = this.phoneNumber;
    data['OTP'] = this.oTP;
    data['age'] = this.age;
    data['trending'] = this.trending;
    data['DOB'] = this.dOB;
    data['height'] = this.height;
    data['user_type'] = this.userType;
    data['fcm_token'] = this.fcmToken;
    data['verify_user'] = this.verifyUser;
    data['phone_verify'] = this.phoneVerify;
    data['Interest'] = this.interest;
    data['hobbies'] = this.hobbies;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['logitude'] = this.logitude;
    data['latitude'] = this.latitude;
    data['profile_status'] = this.profileStatus;
    data['token'] = this.token;
    data['KYC'] = this.kYC;
    data['act_token'] = this.actToken;
    data['Total_review_star'] = this.totalReviewStar;
    data['online_status'] = this.onlineStatus;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}

class PostOwnerInfo {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;
  String? password;
  String? showPassword;
  String? phoneNumber;
  int? age;
  int? trending;
  String? dOB;
  String? height;
  String? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  String? interest;
  String? hobbies;
  String? gender;
  int? oTP;
  String? logitude;
  String? latitude;
  int? profileStatus;
  String? token;
  int? kYC;
  String? actToken;
  String? createdAt;
  String? updateAt;

  PostOwnerInfo(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.profileImage,
      this.password,
      this.showPassword,
      this.phoneNumber,
      this.age,
      this.trending,
      this.dOB,
      this.height,
      this.userType,
      this.fcmToken,
      this.verifyUser,
      this.phoneVerify,
      this.interest,
      this.hobbies,
      this.gender,
      this.oTP,
      this.logitude,
      this.latitude,
      this.profileStatus,
      this.token,
      this.kYC,
      this.actToken,
      this.createdAt,
      this.updateAt});

  PostOwnerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImage = json['profile_image'];
    password = json['password'];
    showPassword = json['show_password'];
    phoneNumber = json['phone_number'];
    age = json['age'];
    trending = json['trending'];
    dOB = json['DOB'];
    height = json['height'];
    userType = json['user_type'];
    fcmToken = json['fcm_token'];
    verifyUser = json['verify_user'];
    phoneVerify = json['phone_verify'];
    interest = json['Interest'];
    hobbies = json['hobbies'];
    gender = json['gender'];
    oTP = json['OTP'];
    logitude = json['logitude'];
    latitude = json['latitude'];
    profileStatus = json['profile_status'];
    token = json['token'];
    kYC = json['KYC'];
    actToken = json['act_token'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['password'] = this.password;
    data['show_password'] = this.showPassword;
    data['phone_number'] = this.phoneNumber;
    data['age'] = this.age;
    data['trending'] = this.trending;
    data['DOB'] = this.dOB;
    data['height'] = this.height;
    data['user_type'] = this.userType;
    data['fcm_token'] = this.fcmToken;
    data['verify_user'] = this.verifyUser;
    data['phone_verify'] = this.phoneVerify;
    data['Interest'] = this.interest;
    data['hobbies'] = this.hobbies;
    data['gender'] = this.gender;
    data['OTP'] = this.oTP;
    data['logitude'] = this.logitude;
    data['latitude'] = this.latitude;
    data['profile_status'] = this.profileStatus;
    data['token'] = this.token;
    data['KYC'] = this.kYC;
    data['act_token'] = this.actToken;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}

class Comments {
  int? id;
  int? userId;
  int? postId;
  String? postComment;
  String? updatedAt;
  String? createdAt;
  String commentOwnerName;
  String profileImage;

  Comments({
    this.id,
    this.userId,
    this.postId,
    this.postComment,
    this.updatedAt,
    this.createdAt,
    required this.commentOwnerName,
    required this.profileImage,
  });

  factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        id: json['id'],
        userId: json['user_id'],
        postId: json['post_id'],
        postComment: json['post_comment'],
        updatedAt: json['updated_at'],
        createdAt: json['created_at'],
        commentOwnerName: json["comment_owner_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'user_id': this.userId,
        'post_id': this.postId,
        'post_comment': this.postComment,
        'updated_at': this.updatedAt,
        'created_at': this.createdAt,
        "comment_owner_name": commentOwnerName,
        "profile_image": profileImage,
      };
}

class Images {
  String profileImage;

  Images({
    required this.profileImage,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "profile_image": profileImage,
      };
}
