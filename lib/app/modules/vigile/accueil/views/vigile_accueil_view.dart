import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/../utils/const.dart';
import '../controllers/vigile_accueil_controller.dart';

class VigileAccueilView extends GetView<VigileAccueilController> {
  const VigileAccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
          opacity: controller.fadeIn,
          child: Image.asset(
            'assets/logo.png',
            width: 130,
            height: 130,
          ),
        ),
      ),
    );
  }
}
