import 'package:get/get.dart';
import '../controllers/vigile_accueil_controller.dart';

class VigileAccueilBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<VigileAccueilController>(VigileAccueilController());
  }
}
