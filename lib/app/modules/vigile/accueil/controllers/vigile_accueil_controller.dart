import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VigileAccueilController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeIn;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    fadeIn = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    animationController.forward();

    Timer(const Duration(seconds: 2), () {
      Get.offNamed('/vigile-connexion');
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
