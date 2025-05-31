import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/pointage_controller.dart';
import '/utils/const.dart';

class PointageView extends GetView<PointageController> {
  const PointageView({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final date = DateTime.now();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header avec déconnexion
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.ac_unit, color: Colors.orange),
                      ElevatedButton.icon(
                        onPressed: () => Get.offAllNamed(Routes.CONNEXION),
                        icon: const Icon(Icons.logout, color: Colors.white, size: 16),
                        label: const Text("Déconnexion"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Bonjour, Abdoulaye",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  /*
                  Text(
                    date as String,
                    style: const TextStyle(color: Colors.white70),
                  ),
                   */
                  const SizedBox(height: 16),

                  // Champ matricule
                  TextField(
                    decoration: InputDecoration(
                      hintText: "MATRICULE",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // Partie blanche avec le scan
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: const EdgeInsets.only(top: 60, bottom: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: media.width * 0.6,
                                height: media.width * 0.6,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    "assets/qr_code.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                "Scannez pour pointer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Bouton Scan flottant
                  Positioned(
                    top: -30,
                    left: 24,
                    right: 24,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: (){
                          Get.offAllNamed(Routes.DETAIL_ETUDIANT);
                        },
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text("Scan"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
