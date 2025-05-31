import 'package:get/get.dart';
import '../controllers/vigile_pointage_controller.dart';

class VigilePointageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VigilePointageController>(() => VigilePointageController());
  }
}
