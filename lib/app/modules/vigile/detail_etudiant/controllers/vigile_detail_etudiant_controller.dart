import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class VigileDetailEtudiantController extends GetxController {
  final date = DateFormat('MM/dd/yyyy').format(DateTime.now());
  final matriculeController = TextEditingController(text: "001");

  @override
  void onClose() {
    matriculeController.dispose();
    super.onClose();
  }
}
