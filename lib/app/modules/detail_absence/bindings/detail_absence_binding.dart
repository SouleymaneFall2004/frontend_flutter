import 'package:get/get.dart';

import '../controllers/detail_absence_controller.dart';

class DetailAbsenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailAbsenceController>(() => DetailAbsenceController());
  }
}
