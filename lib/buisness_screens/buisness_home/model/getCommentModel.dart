class GetCommentModel {
  bool? success;
  String? message;
  int? status;
  List<Comments>? comments;

  GetCommentModel({this.success, this.message, this.status, this.comments});

  GetCommentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    status = json['status'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  int? id;
  int? businessId;
  int? postId;
  String? postComment;
  String? createdAt;
  String? updatedAt;
  String? commentOwnerName;
  String? profileImage;

  Comments({this.id, this.businessId, this.postId, this.postComment, this.createdAt, this.updatedAt, this.commentOwnerName, this.profileImage});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    postId = json['post_id'];
    postComment = json['post_comment'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    commentOwnerName = json['comment_owner_name'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['post_id'] = this.postId;
    data['post_comment'] = this.postComment;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['comment_owner_name'] = this.commentOwnerName;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
