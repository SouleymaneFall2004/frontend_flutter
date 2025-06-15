import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../services/hive_db.dart';
import '../../../routes/app_pages.dart';
import '../controllers/accueil_controller.dart';

class AccueilView extends GetView<AccueilController> {
  const AccueilView({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final formattedDate = "${date.month}/${date.day}/${date.year}";
    final user = HiveDb().getUser();
    final nom = user?['prenom'] ?? 'Utilisateur';

    return Scaffold(
      backgroundColor: const Color(0xFF4B2E1D),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.LISTE_ABSENCE);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.assignment, color: Color(0xFF4B2E1D)),
                    SizedBox(height: 4),
                    Text(
                      "Absences",
                      style: TextStyle(color: Color(0xFF4B2E1D)),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.CARTE);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.map, color: Colors.orange),
                    SizedBox(height: 4),
                    Text("Map", style: TextStyle(color: Colors.orange)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  HiveDb().clearData();
                  Get.offAllNamed(Routes.CONNEXION);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(height: 4),
                    Text("Quitter", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: MediaQuery.of(context).size.height * 0.12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.ac_unit, color: Colors.orange, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    "Bonjour, $nom",
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    QrImageView(
                      data: controller.generateQrData(),
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.6,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
