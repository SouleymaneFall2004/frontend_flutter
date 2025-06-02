import 'package:get/get.dart';

import '../controllers/detail_etudiant_controller.dart';

class DetailEtudiantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailEtudiantController>(
      () => DetailEtudiantController(),
    );
  }
}
