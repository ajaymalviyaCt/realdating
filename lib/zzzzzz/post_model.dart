

class PostModel {
  int id = 0;
  String? title;

  int? competitionId = 0;

  int totalView = 0;
  int totalLike = 0;
  int totalComment = 0;
  int totalShare = 0;
  int isWinning = 0;
  bool isLike = false;
  bool isSaved = false;
  bool commentsEnabled = true;

  bool isReported = false;
  bool isSharePost = false;

  List<String> tags = [];
  List<MentionedUsers> mentionedUsers = [];

  String shareLink = '';

  String postTime = '';
  DateTime? createDate;
  PostModel? sharedPost;

  Map? contentRefrence;

  PostModel();
}

class MentionedUsers {
  int id = 0;
  String userName = '';

  MentionedUsers();

  factory MentionedUsers.fromJson(dynamic json) {
    MentionedUsers model = MentionedUsers();
    model.id = json['user_id'];
    model.userName = json['username'].toString().toLowerCase();
    return model;
  }
}

class PostInsight {
  int totalView;
  int totalImpression;
  int totalShare;

  int viewFromFollowers;
  int viewFromNonFollowers;
  int viewFromMale;
  int viewFromFemale;
  int viewFromOther;
  int viewFromGenderNotDisclosed;
  int viewFromCountryNotDisclosed;
  int viewFromProfileCategoryNotDisclosed;
  int viewFromAgeNotDisclosed;
  int profileViewFromPost;
  int followFromPost;

  PostInsight({
    required this.totalView,
    required this.totalImpression,
    required this.totalShare,
    required this.viewFromFollowers,
    required this.viewFromNonFollowers,
    required this.viewFromMale,
    required this.viewFromFemale,
    required this.viewFromOther,
    required this.viewFromGenderNotDisclosed,
    required this.viewFromCountryNotDisclosed,
    required this.viewFromProfileCategoryNotDisclosed,
    required this.viewFromAgeNotDisclosed,
    required this.profileViewFromPost,
    required this.followFromPost,
  });

  factory PostInsight.fromJson(dynamic json) => PostInsight(
      totalView: json['total_view'],
      totalImpression: json['total_impression'],
      totalShare: json['total_share'] ?? 0,
      viewFromFollowers: json['follower'],
      viewFromNonFollowers: json['nonfollower'],
      viewFromMale: json['male'],
      viewFromFemale: json['female'],
      viewFromOther: json['other'],
      viewFromGenderNotDisclosed: json['gender_not_disclose'],
      viewFromCountryNotDisclosed: json['country_not_disclose'],
      viewFromProfileCategoryNotDisclosed: json['profile_category_type_not_disclose'],
      viewFromAgeNotDisclosed: json['age_not_disclose'],
      profileViewFromPost: json['profile_view'],
      followFromPost: json['follow_by_post']);
}
