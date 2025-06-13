import 'package:get/get.dart';

import '../../../../services/hive_db.dart';

class AccueilController extends GetxController {
  String generateQrData() {
    final user = HiveDb().getUser();
    final matricule = user?['matricule'] ?? 'inconnu';
    return '{"matricule": "$matricule"}';
  }
}
