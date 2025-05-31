import 'package:get/get.dart';
import '../controllers/vigile_detail_etudiant_controller.dart';

class VigileDetailEtudiantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VigileDetailEtudiantController>(() => VigileDetailEtudiantController());
  }
}
