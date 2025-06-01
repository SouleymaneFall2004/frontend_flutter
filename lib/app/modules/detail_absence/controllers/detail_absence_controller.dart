import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailAbsenceController extends GetxController {
  Future<void> ajouterJustificatif(String absenceId, String justification) async {
    final uri = Uri.parse("https://dev-back-end-sd0s.onrender.com/api/mobile/absences/ajouter_justificatif/$absenceId");

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"justification": justification}),
      );

      if (response.statusCode == 200) {
        Get.snackbar("Succès", "Justificatif ajouté avec succès.");
      } else {
        Get.snackbar("Erreur", "Échec de l'ajout du justificatif.");
      }
    } catch (e) {
      Get.snackbar("Exception", "Une erreur s'est produite : $e");
    }
  }
}
