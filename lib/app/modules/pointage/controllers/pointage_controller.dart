import 'dart:convert';

import 'package:get/get.dart';

import '../../../../services/api.dart';
import '../../../../services/hive_db.dart';

class PointageController extends GetxController {
  var etudiant = {}.obs;
  final vigileId = HiveDb().getUser()?['vigileId'];
  final apiService = Api();

  String generateQrData() {
    return '{message: hello stalker!}';
  }

  Future<void> fetchEtudiantByMatricule(String matricule) async {
    try {
      final response = await apiService.get('/api/mobile/etudiants/$matricule');
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        etudiant.value = body['data'] ?? {};
        final pointage = await apiService.get('/api/mobile/pointages/create?etudiantId=${body['data']['etudiantId']}&vigileId=$vigileId');
        if (pointage.statusCode == 201) {
          Get.snackbar('Succès', 'Étudiant pointé avec succès');
        } else {
          Get.snackbar('Erreur', 'Étudiant non pointé (${pointage.statusCode})');
        }
      } else {
        etudiant.value = {};
        Get.snackbar('Erreur', 'Étudiant non trouvé (${response.statusCode})');
      }
    } catch (e) {
      etudiant.value = {};
      Get.snackbar('Erreur', 'Une erreur est survenue : $e');
    }
  }
}
