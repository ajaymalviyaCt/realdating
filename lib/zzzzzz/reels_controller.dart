// import 'package:realdating/components/post_card_controller.dart';
// import 'package:realdating/helper/imports/common_import.dart';
// import 'package:realdating/model/post_model.dart';
// import 'package:realdating/model/post_search_query.dart';
// import '../api_handler/apis/post_api.dart';
// import 'package:realdating/helper/list_extension.dart';
//
// class ReelsController extends GetxController {
//
//
//   bool isLoadingReelsWithAudio = false;
//   int reelsWithAudioCurrentPage = 1;
//   bool canLoadMoreReelsWithAudio = true;
//
//   bool isLoadingReels = false;
//   int reelsCurrentPage = 1;
//   bool canLoadMoreReels = true;
//
//   clearReels() {
//     isLoadingReels = false;
//     reelsCurrentPage = 1;
//     canLoadMoreReels = true;
//
//
//     update();
//   }
//
//   clearReelsWithAudio() {
//     isLoadingReelsWithAudio = false;
//     reelsWithAudioCurrentPage = 1;
//     canLoadMoreReelsWithAudio = true;
//
//   }
//
//
//
//
//
//
//
//
//
//   void likeUnlikeReel({required PostModel post}) {
//     post.isLike = !post.isLike;
//     if (post.isLike) {
//       likedReels.add(post);
//       currentViewingReel.value?.totalLike += 1;
//     } else {
//       likedReels.remove(post);
//       currentViewingReel.value?.totalLike -= 1;
//     }
//     likedReels.refresh();
//     // post.totalLike = post.isLike ? (post.totalLike) + 1 : (post.totalLike) - 1;
//     PostApi.likeUnlikePost(like: post.isLike, postId: post.id);
//   }
//
//   deletePost({required PostModel post}) {
//     final PostCardController postCardController = Get.find();
//     postCardController.deletePost(post: post, callback: () {});
//
//     publicReels.removeWhere((element) => element.id == post.id);
//     filteredReels.removeWhere((element) => element.id == post.id);
//     likedReels.removeWhere((element) => element.id == post.id);
//
//     AppUtil.showToast(message: deletedString.tr, isSuccess: true);
//   }
//
//   void blockUser({required int userId, required VoidCallback callback}) {
//     final PostCardController postCardController = Get.find();
//     postCardController.blockUser(userId: userId, callback: () {});
//
//     publicReels.removeWhere((element) => element.user.id == userId);
//     filteredReels.removeWhere((element) => element.user.id == userId);
//     likedReels.removeWhere((element) => element.user.id == userId);
//   }
//
//   sharePost({required PostModel post}) {
//     final PostCardController postCardController = Get.find();
//     postCardController.sharePost(post: post);
//   }
// }
