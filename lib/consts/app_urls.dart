const String baseUrl = 'https://forreal.net:4000/';

class Appurls {
  static final Uri signUp = Uri.parse('https://forreal.net:4000/users/signUp');
  static final Uri login = Uri.parse('https://forreal.net:4000/loginbusiness');
  static final Uri userLogin = Uri.parse('https://forreal.net:4000/users/loginUser');
  static final Uri otp_verifcation = Uri.parse('https://forreal.net:4000/users/phone_code_verification');
  static final Uri email_verifcation = Uri.parse('https://forreal.net:4000/users/OTP_verifcation_forget_password');
  static final Uri changepassword = Uri.parse('https://forreal.net:4000/users/change_Password');
  static final Uri newPassword = Uri.parse('https://forreal.net:4000/users/change_Password_forget_password');
  static final Uri get_all_users = Uri.parse('https://forreal.net:4000/users/get_all_users');
  static final Uri trending = Uri.parse('https://forreal.net:4000/users/TREnding_users');
  static final Uri allPostHome = Uri.parse('https://forreal.net:4000/Get_all_post');
  static final Uri mapUrl = Uri.parse('https://forreal.net:4000/users/nearByBussiness');

  /// polls
  static final Uri allPolls = Uri.parse('https://forreal.net:4000/allPolls');

  static final Uri pollResponseUrl = Uri.parse('https://forreal.net:4000/poll_response');

  /// get my friends
  ///
  static final Uri getMyFriendUrl = Uri.parse('https://forreal.net:4000/users/get_my_friend');
  static final Uri forgotPassword = Uri.parse('${baseUrl}forgotPassword');

  static final Uri matches = Uri.parse('https://forreal.net:4000/users/get_all_users');
  static final Uri get_user_by_id = Uri.parse('https://forreal.net:4000/users/get_user_by_id');

  static final Uri events = Uri.parse('https://forreal.net:4000/users/get_event');
  static final Uri eventDetails = Uri.parse('https://forreal.net:4000/users/get_event_by_id');
  static final Uri gender = Uri.parse('https://forreal.net:4000/users/editProfile');
  static final Uri profile = Uri.parse('https://forreal.net:4000/users/myprofile');
  static final Uri editProfile = Uri.parse('https://forreal.net:4000/users/editProfile');
  static final Uri addYourPhotoas = Uri.parse('https://forreal.net:4000/users/add_Profile_images');
  static final Uri review = Uri.parse('https://forreal.net:4000/users/review_rating');

/////////////Buisness///////////

  static final Uri buisnesssignUp = Uri.parse('https://forreal.net:4000/signUp_business');

  static final Uri buisnesslogin = Uri.parse('https://forreal.net:4000/loginbusiness');

  static final Uri mydeal = Uri.parse('https://forreal.net:4000/MY_deals');

  static final Uri creatads = Uri.parse('https://forreal.net:4000/get_advs');

  static final Uri createdeal = Uri.parse('https://forreal.net:4000/create_deals');

  static final Uri buisnessprofile = Uri.parse('https://forreal.net:4000/myprofile');
  static final Uri buisnessKYCDocument = Uri.parse('https://forreal.net:4000/business_document_1');
  static final Uri buisnessKYCIdentificationUrl = Uri.parse('https://forreal.net:4000/business_document_camera');

  static final Uri buisnessAllPostHome = Uri.parse('https://forreal.net:4000/Get_all_business_post');

  /// Edit deal Url
  static final Uri editdealupdate = Uri.parse('https://forreal.net:4000/update_deals');
  static final Uri editdealdelete = Uri.parse('https://forreal.net:4000/delete_deals');
  static final Uri getsallads = Uri.parse('https://forreal.net:4000/get_advs');
  static final Uri getAllReels = Uri.parse('https://forreal.net:4000/Get_all_reel');
  static final Uri editadsupdate = Uri.parse('https://forreal.net:4000/update_advs');
  static final Uri adsdelete = Uri.parse('https://forreal.net:4000/delete_adv');

  /// post
  static final Uri postDelete = Uri.parse('https://forreal.net:4000/delete_business_post');
  static final Uri postDeleteUser = Uri.parse('https://forreal.net:4000/delete_post');
  static final Uri postLike = Uri.parse('https://forreal.net:4000/Like_business_post');
  static final Uri postLikeUser = Uri.parse('https://forreal.net:4000/Like_post');
  static final Uri postComment = Uri.parse('https://forreal.net:4000/comment_business_post');
  static final Uri userPostComment = Uri.parse('https://forreal.net:4000/comment_post');
  static final Uri postGetComment = Uri.parse('https://forreal.net:4000/business_post_comments');
  static final Uri dashBoadrdUri = Uri.parse('https://forreal.net:4000/Get_dashboard');

  // static final  Uri mydeal = Uri.parse('https://forreal.net:4000/MY_deals');

  /// Profile URl

  static final Uri businessAddCoverUrl = Uri.parse('https://forreal.net:4000/add_cover_photo');
  static final Uri myProfileUrl = Uri.parse('https://forreal.net:4000/myprofile');
  static final Uri userGetDiscover = Uri.parse('https://forreal.net:4000/users/fvery');

  /// Support

  static final Uri supportUri = Uri.parse('https://forreal.net:4000/users/support');
}
