import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PointageController extends GetxController {
  var etudiant = {}.obs;

  String generateQrData() {
    return '{message: hello stalker!}';
  }

  Future<void> fetchEtudiantByMatricule(String matricule) async {
    final url = Uri.parse("https://dev-back-end-sd0s.onrender.com/api/mobile/etudiants/$matricule");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        etudiant.value = body['data'] ?? {};
      } else {
        etudiant.value = {};
      }
    } catch (e) {
      etudiant.value = {};
    }
  }
}
