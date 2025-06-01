import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../global/user_controller.dart';
import '../../../routes/app_pages.dart';

class ConnexionController extends GetxController {
  final isLoading = false.obs;
  final messageErreur = ''.obs;
  final userController = Get.find<UserController>();

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

    final response = await http.post(
      Uri.parse('https://dev-back-end-sd0s.onrender.com/api/mobile/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'login': identifiant, 'password': motDePasse}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['user'] != null) {
        userController.setUser(data['user']);
        if (data['user']['role'] == 'ETUDIANT') {
          Get.offAllNamed(Routes.ACCUEIL);
        }
        if (data['user']['role'] == 'VIGILE') {
          Get.offAllNamed(Routes.POINTAGE);
        }
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
