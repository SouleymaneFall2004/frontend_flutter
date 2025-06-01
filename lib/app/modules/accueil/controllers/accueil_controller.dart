import 'package:get/get.dart';
import '../../../global/user_controller.dart';

class AccueilController extends GetxController {
  String generateQrData() {
    final user = Get.find<UserController>().user.value;
    final matricule = user?['matricule'] ?? 'inconnu';
    return '{"matricule": "$matricule"}';
  }
}
