import 'package:get/get.dart';

import '../controllers/carte_controller.dart';

class CarteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CarteController>(() => CarteController());
  }
}
