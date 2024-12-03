import 'package:camera/camera.dart';
import 'package:realdating/zzzzzz/colors_file.dart';
import 'package:realdating/zzzzzz/common_import.dart';
import 'package:realdating/zzzzzz/create_reel_video.dart';
import 'package:realdating/zzzzzz/manager/player_manager.dart';

import 'content_creator_view.dart';
import 'create_reel_controller.dart';
List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
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

Future<void> goToCreateReelScreen() async {
  try {
    cameras = await availableCameras();
  } catch (e, s) {
    print("line 105");
  }
  Get.delete<PlayerManager>(force: true);
  Get.delete<CreateReelController>(force: true);
  Get.delete<CameraControllerService>(force: true);
  Get.delete<SettingsController>(force: true);
  Get.put(PlayerManager());



  // Get.put(ReelsController());
  Get.put(CreateReelController());

  Get.put(CameraControllerService());
  await Get.find<CameraControllerService>().initializeCamera(CameraLensDirection.front);
  Get.put(SettingsController());
  Get.to(CreateReelScreen());
}
