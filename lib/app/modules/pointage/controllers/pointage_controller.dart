import 'dart:convert';
import 'package:get/get.dart';
import '../../../../services/api_service.dart';

class PointageController extends GetxController {
  var etudiant = {}.obs;
  final apiService = ApiService();

  String generateQrData() {
    return '{message: hello stalker!}';
  }

  Future<void> fetchEtudiantByMatricule(String matricule) async {
    try {
      final response = await apiService.get('/api/mobile/etudiants/$matricule');
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        etudiant.value = body['data'] ?? {};
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
