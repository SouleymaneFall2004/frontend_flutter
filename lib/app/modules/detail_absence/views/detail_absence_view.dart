import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/detail_absence_controller.dart';

class DetailAbsenceView extends GetView<DetailAbsenceController> {
  const DetailAbsenceView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController motifController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: const Row(
          children: [
            Icon(Icons.assignment),
            SizedBox(width: 8),
            Text("Mes Absences"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            const Text(
              "Cours 1",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("• Nom: Fluter"),
            const Text("• Date et Heure: 21/05/2025 - 08h-12h"),
            const Text("• Enseignant: Baila Wane"),
            const Text("• Etat: Non Justifié"),
            const SizedBox(height: 24),
            const Text("Motif de l'absence"),
            const SizedBox(height: 8),
            TextFormField(
              controller: motifController,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Saisissez un motif...",
              ),
            ),
            const SizedBox(height: 24),
            const Text("Ajouter un justificatif"),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.upload),
              label: const Text("Insérer un fichier ou une image"),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4B2E1D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Soumettre",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
