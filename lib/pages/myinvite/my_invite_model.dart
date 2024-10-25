// import 'dart:convert';
//
// MyInviteModel MyInviteModelFromJson(String str) => MyInviteModel.fromJson(json.decode(str));
//
// String MyInviteModelToJson(MyInviteModel data) => json.encode(data.toJson());
//
// class MyInviteModel {
//   bool success;
//   String message;
//   int status;
//   List<dynamic> MyInviteModels;
//
//   MyInviteModel({
//     required this.success,
//     required this.message,
//     required this.status,
//     required this.MyInviteModels,
//   });
//
//   factory MyInviteModel.fromJson(Map<String, dynamic> json) => MyInviteModel(
//     success: json["success"],
//     message: json["message"],
//     status: json["status"],
//     MyInviteModels: List<dynamic>.from(json["My_invites"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "success": success,
//     "message": message,
//     "status": status,
//     "My_invites": List<dynamic>.from(MyInviteModels.map((x) => x)),
//   };
// }
