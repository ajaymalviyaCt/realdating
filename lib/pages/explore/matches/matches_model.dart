import 'dart:convert';

class MatchesModel {
  String? message;
  List<MyFriend>? myFriends;
  bool? success;
  int? status;

  MatchesModel({
    this.message,
    this.myFriends,
    this.success,
    this.status,
  });

  factory MatchesModel.fromRawJson(String str) => MatchesModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchesModel.fromJson(Map<String, dynamic> json) => MatchesModel(
    message: json["message"],
    myFriends: json["my_friends"] == null ? [] : List<MyFriend>.from(json["my_friends"]!.map((x) => MyFriend.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "my_friends": myFriends == null ? [] : List<dynamic>.from(myFriends!.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class MyFriend {
  int? friendId;
  String? friendFirstName;
  String? friendLastName;
  String? friendUsername;
  String? profileImage;
  int? age;
  List<Image>? images;

  MyFriend({
    this.friendId,
    this.friendFirstName,
    this.friendLastName,
    this.friendUsername,
    this.profileImage,
    this.age,
    this.images,
  });

  factory MyFriend.fromRawJson(String str) => MyFriend.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyFriend.fromJson(Map<String, dynamic> json) => MyFriend(
    friendId: json["friend_id"],
    friendFirstName: json["friend_first_name"],
    friendLastName: json["friend_last_name"],
    friendUsername: json["friend_username"],
    profileImage: json["profile_image"],
    age: json["age"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "friend_id": friendId,
    "friend_first_name": friendFirstName,
    "friend_last_name": friendLastName,
    "friend_username": friendUsername,
    "profile_image": profileImage,
    "age": age,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}

class Image {
  String? profileImages;

  Image({
    this.profileImages,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    profileImages: json["profile_images"],
  );

  Map<String, dynamic> toJson() => {
    "profile_images": profileImages,
  };
}
