import 'package:camera/camera.dart';
import 'package:realdating/zzzzzz/runnnnnnnnn.dart';

import 'common_import.dart';

class CameraControllerService extends GetxController {
  late CameraController controller;

  Future<void> initializeCamera(CameraLensDirection lensDirection) async {
    final camera = camerassss.firstWhere((camera) => camera.lensDirection == lensDirection);

    controller = CameraController(camera, ResolutionPreset.max);
    await controller.initialize().then((_) {}).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });

    update(); // Notify listeners
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class CameraView extends StatelessWidget {
  const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraControllerService>(
      builder: (controllerService) {
        return CameraPreview(controllerService.controller).round(20);
      },
    );
  }
}
