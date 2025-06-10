import 'package:get/get.dart';

import '../controllers/liste_absence_controller.dart';

class ListeAbsenceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListeAbsenceController>(() => ListeAbsenceController());
  }
}
