import 'package:flutter/material.dart';
import 'package:frontend_flutter/app/modules/liste_absence/views/liste_absence_view.dart';
import 'package:get/get.dart';

import '../controllers/detail_absence_controller.dart';

class DetailAbsenceView extends StatelessWidget {
  final Map<String, dynamic> absence;
  final DetailAbsenceController controller = Get.put(DetailAbsenceController());

  DetailAbsenceView({super.key, required this.absence});

  @override
  Widget build(BuildContext context) {
    final String? motif = absence['justification'];
    final TextEditingController motifController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
            Text(
              "Absence du ${absence['dateDebut'] ?? '---'}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "• Heure: ${absence['heureDebut'] ?? '---'} - ${absence['heureFin'] ?? '---'}",
            ),
            Text("• Type: ${absence['type'] ?? '---'}"),
            Text("• État: ${absence['etat'] ?? '---'}"),
            const SizedBox(height: 24),
            const Text("Motif de l'absence"),
            const SizedBox(height: 8),
            TextFormField(
              controller: motifController,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: motif ?? "Saisissez un motif...",
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
              onPressed: () async {
                final String justification = motifController.text.trim();
                if (justification.isEmpty) return;
                await controller.ajouterJustificatif(
                  absence['id'],
                  justification,
                );
                Get.off(
                  () => const ListeAbsenceView(),
                  transition: Transition.leftToRight,
                );
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
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
