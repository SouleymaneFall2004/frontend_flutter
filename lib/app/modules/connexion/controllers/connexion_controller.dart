import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../accueil/views/accueil_view.dart';

class ConnexionController extends GetxController {
  final isLoading = false.obs;
  final messageErreur = ''.obs;

  Future<void> seConnecter(String identifiant, String motDePasse) async {
    isLoading.value = true;
    messageErreur.value = '';

    final response = await http.post(
      Uri.parse('https://dev-back-end-sd0s.onrender.com/api/mobile/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'login': identifiant,
        'password': motDePasse,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['user'] != null /* && data['user']['role'] == 'etudiant'*/) {
        Get.offAll(() => const AccueilView());
      } else {
        messageErreur.value = 'Ce compte n\'est pas un étudiant';
      }
    } else {
      try {
        final data = jsonDecode(response.body);
        messageErreur.value = data['message'] ?? 'Erreur inconnue';
      } catch (_) {
        messageErreur.value = 'La requête ne passe pas';
      }
    }

    isLoading.value = false;
  }
}
