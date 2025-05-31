import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VigilePointageController extends GetxController {
  final TextEditingController matriculeController = TextEditingController();

  void pointerEtudiant() {
    final matricule = matriculeController.text.trim();

    Get.snackbar(
      "Succès",
      "Pointage réussi",
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      Get.toNamed('/vigile-detail-etudiant');
    });
  }

  @override
  void onClose() {
    matriculeController.dispose();
    super.onClose();
  }
}
