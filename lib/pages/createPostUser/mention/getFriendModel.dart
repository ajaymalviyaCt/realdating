class GetAllFriendModel {
  String? message;
  List<MyFriends>? myFriends;
  bool? success;
  int? status;

  GetAllFriendModel({this.message, this.myFriends, this.success, this.status});

  GetAllFriendModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['my_friends'] != null) {
      myFriends = <MyFriends>[];
      json['my_friends'].forEach((v) {
        myFriends!.add(new MyFriends.fromJson(v));
      });
    }
    success = json['success'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.myFriends != null) {
      data['my_friends'] = this.myFriends!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['status'] = this.status;
    return data;
  }
}

class MyFriends {
  int? friendId;
  String? friendFirstName;
  String? friendLastName;
  String? friendUsername;
  String? profileImage;
  List<Images>? images;

  MyFriends(
      {this.friendId,
        this.friendFirstName,
        this.friendLastName,
        this.friendUsername,
        this.profileImage,
        this.images});

  MyFriends.fromJson(Map<String, dynamic> json) {
    friendId = json['friend_id'];
    friendFirstName = json['friend_first_name'];
    friendLastName = json['friend_last_name'];
    friendUsername = json['friend_username'];
    profileImage = json['profile_image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friend_id'] = this.friendId;
    data['friend_first_name'] = this.friendFirstName;
    data['friend_last_name'] = this.friendLastName;
    data['friend_username'] = this.friendUsername;
    data['profile_image'] = this.profileImage;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? profileImages;

  Images({this.profileImages});

  Images.fromJson(Map<String, dynamic> json) {
    profileImages = json['profile_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_images'] = this.profileImages;
    return data;
  }
}
