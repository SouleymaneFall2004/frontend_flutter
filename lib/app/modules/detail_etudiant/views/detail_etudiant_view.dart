import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/detail_etudiant_controller.dart';

class DetailEtudiantView extends GetView<DetailEtudiantController> {
  const DetailEtudiantView({super.key, required Map<String, String> studentData});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final formattedDate = "${date.month}/${date.day}/${date.year}";

    return Scaffold(
      backgroundColor: const Color(0xFF4B2E1D),
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
                  const Text(
                    "Bonjour, Abdoulaye",
                    style: TextStyle(fontSize: 24, color: Colors.white),
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
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    const SizedBox(height: 24),
                    _buildInfoField("Nom Complet", "Abdoulaye Ly"),
                    _buildInfoField("Classe", "L3GLRS"),
                    _buildInfoField("Matricule", "01"),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
                  Get.offAllNamed(Routes.POINTAGE);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.qr_code_scanner, color: Color(0xFF4B2E1D)),
                    SizedBox(height: 4),
                    Text("Scan", style: TextStyle(color: Color(0xFF4B2E1D))),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAllNamed(Routes.CONNEXION);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(height: 4),
                    Text("Déconnexion", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 4),
          TextField(
            enabled: false,
            controller: TextEditingController(text: value),
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
