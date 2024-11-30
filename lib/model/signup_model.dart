class signup_model {
  int? status;
  bool? success;
  String? message;
  String? token;
  UserInfo? userInfo;

  signup_model({this.status, this.success, this.message, this.token, this.userInfo});

  signup_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    token = json['token'];
    userInfo = json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (userInfo != null) {
      data['user_info'] = userInfo!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['profile_image'] = profileImage;
    data['password'] = password;
    data['show_password'] = showPassword;
    data['phone_number'] = phoneNumber;
    data['age'] = age;
    data['gender'] = gender;
    data['DOB'] = dOB;
    data['height'] = height;
    data['user_type'] = userType;
    data['fcm_token'] = fcmToken;
    data['verify_user'] = verifyUser;
    data['phone_verify'] = phoneVerify;
    data['Interest'] = interest;
    data['hobbies'] = hobbies;
    data['OTP'] = oTP;
    data['token'] = token;
    data['act_token'] = actToken;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    return data;
  }
}
