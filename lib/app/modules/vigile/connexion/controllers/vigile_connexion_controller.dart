import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VigileConnexionController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() {
    // Pour l’instant navigation statique
    Get.toNamed('/vigile-pointage');
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
