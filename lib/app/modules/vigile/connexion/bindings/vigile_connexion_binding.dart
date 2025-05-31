import 'package:get/get.dart';
import '../controllers/vigile_connexion_controller.dart';

class VigileConnexionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VigileConnexionController>(() => VigileConnexionController());
  }
}
