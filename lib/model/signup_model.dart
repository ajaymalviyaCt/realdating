class signup_model {
  int? status;
  bool? success;
  String? message;
  String? token;
  UserInfo? userInfo;

  signup_model(
      {this.status, this.success, this.message, this.token, this.userInfo});

  signup_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
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
  String? gender;
  String? dOB;
  String? height;
  String? userType;
  String? fcmToken;
  int? verifyUser;
  int? phoneVerify;
  String? interest;
  String? hobbies;
  int? oTP;
  String? token;
  String? actToken;
  String? createdAt;
  String? updateAt;

  UserInfo(
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
        this.gender,
        this.dOB,
        this.height,
        this.userType,
        this.fcmToken,
        this.verifyUser,
        this.phoneVerify,
        this.interest,
        this.hobbies,
        this.oTP,
        this.token,
        this.actToken,
        this.createdAt,
        this.updateAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
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
    gender = json['gender'];
    dOB = json['DOB'];
    height = json['height'];
    userType = json['user_type'];
    fcmToken = json['fcm_token'];
    verifyUser = json['verify_user'];
    phoneVerify = json['phone_verify'];
    interest = json['Interest'];
    hobbies = json['hobbies'];
    oTP = json['OTP'];
    token = json['token'];
    actToken = json['act_token'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['gender'] = this.gender;
    data['DOB'] = this.dOB;
    data['height'] = this.height;
    data['user_type'] = this.userType;
    data['fcm_token'] = this.fcmToken;
    data['verify_user'] = this.verifyUser;
    data['phone_verify'] = this.phoneVerify;
    data['Interest'] = this.interest;
    data['hobbies'] = this.hobbies;
    data['OTP'] = this.oTP;
    data['token'] = this.token;
    data['act_token'] = this.actToken;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    return data;
  }
}
