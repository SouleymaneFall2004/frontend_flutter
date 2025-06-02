import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/api_service.dart';
import '../../../global/user_controller.dart';
import '../../../routes/app_pages.dart';

class ConnexionController extends GetxController {
  final isLoading = false.obs;
  final messageErreur = ''.obs;
  final userController = Get.find<UserController>();
  final apiService = ApiService();

  final identifiantController = TextEditingController();
  final motDePasseController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    resetChamps();
  }

  void resetChamps() {
    identifiantController.clear();
    motDePasseController.clear();
    messageErreur.value = '';
  }

  @override
  void onClose() {
    identifiantController.dispose();
    motDePasseController.dispose();
    super.onClose();
  }

  Future<void> seConnecter(String identifiant, String motDePasse) async {
    isLoading.value = true;
    messageErreur.value = '';

    try {
      final response = await apiService.post(
        '/api/mobile/auth/login',
        body: jsonEncode({'login': identifiant, 'password': motDePasse}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['user'] != null) {
          userController.setUser(data['user']);
          if (data['user']['role'] == 'ETUDIANT') {
            Get.offAllNamed(Routes.ACCUEIL);
          } else if (data['user']['role'] == 'VIGILE') {
            Get.offAllNamed(Routes.POINTAGE);
          } else {
            Get.snackbar('Erreur', 'Rôle utilisateur inconnu !');
          }
        } else {
          messageErreur.value = 'Utilisateur non reconnu';
        }
      } else {
        try {
          final data = jsonDecode(response.body);
          messageErreur.value = data['message'] ?? 'Erreur inconnue';
        } catch (_) {
          messageErreur.value = 'Erreur inattendue lors de la connexion';
        }
      }
    } catch (e) {
      messageErreur.value = 'Erreur réseau ou serveur : $e';
    } finally {
      isLoading.value = false;
    }
  }
}
