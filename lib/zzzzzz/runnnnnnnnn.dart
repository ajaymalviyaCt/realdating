import 'package:camera/camera.dart';
import 'package:realdating/zzzzzz/colors_file.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:realdating/zzzzzz/create_reel_video.dart';
import 'package:realdating/zzzzzz/manager/player_manager.dart';

import 'content_creator_view.dart';
import 'create_reel_controller.dart';

late List<CameraDescription> camerassss;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    camerassss = await availableCameras();
  } catch (e, s) {
    print("line 105");
  }
  Get.put(PlayerManager());

  Get.put(PlayerManager());

  // Get.put(ReelsController());
  Get.put(CreateReelController());

  Get.put(CameraControllerService());
  await Get.find<CameraControllerService>().initializeCamera(CameraLensDirection.back);
  Get.put(SettingsController());

  print("line 108");
  runApp(GetMaterialApp(
    home: CreateReelScreen(),
  ));
}
