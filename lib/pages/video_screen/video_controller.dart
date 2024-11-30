import 'package:realdating/pages/video_screen/video.dart';
import 'package:get/get.dart';

import '../../consts/app_urls.dart';
import '../../services/base_client01.dart';
import '../reels/reelModel.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  List<Reel> reels = <Reel>[].obs;
  RxBool load = false.obs;

  RxBool isLoadig = false.obs;

  @override
  void onInit() {
    super.onInit();
    watchReels();
    print("fsfsfsdfsfs");
  }

  GetReelsModel? getReelModel;

  watchReels() async {
    isLoadig(true);
    final response = await BaseClient01().get(Appurls.getAllReels);
    isLoadig(false);
    print(response);

    print("fsfsfsdfsfs");
    try {
      getReelModel = GetReelsModel.fromJson(response);
      reels = GetReelsModel.fromJson(response).reels;
    } catch (e) {
      print("sad1234567sfsffsf$e");
    }
  }
}
