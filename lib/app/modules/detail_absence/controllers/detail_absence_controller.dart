import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../accueil/views/accueil_view.dart';

class DetailAbsenceController extends GetxController {
  Future<void> ajouterJustificatif({
    required String absenceId,
    required String justification,
    required String message,
    required String justificationImage,
  }) async {
    final uri = Uri.parse(
      "https://dev-back-end-sd0s.onrender.com/api/mobile/absences/evenements/$absenceId/justificatif",
    );

    try {
      final response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "justification": justification,
          "message": message,
          "justificationImage": justificationImage,
        }),
      );

      if (response.statusCode == 200) {
        Get.offAll(
          () => const AccueilView(),
          transition: Transition.rightToLeft,
        );
      }
    } catch (e) {
      Get.snackbar("Exception", "Une erreur s'est produite : $e");
    }
  }
}
