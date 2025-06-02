import 'package:get/get.dart';

import '../controllers/connexion_controller.dart';

class ConnexionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnexionController>(
      () => ConnexionController(),
    );
  }
}
