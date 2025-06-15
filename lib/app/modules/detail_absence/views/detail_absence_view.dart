import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_absence_controller.dart';

class DetailAbsenceView extends StatefulWidget {
  final Map<String, dynamic> absence;

  const DetailAbsenceView({super.key, required this.absence});

  @override
  State<DetailAbsenceView> createState() => _DetailAbsenceViewState();
}

class _DetailAbsenceViewState extends State<DetailAbsenceView> {
  final DetailAbsenceController controller = Get.find();
  final TextEditingController motifController = TextEditingController();

  @override
  void dispose() {
    motifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> absence = widget.absence;
    final String? motif = absence['justification'];

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
            const Text("Ajouter des justificatifs"),
            const SizedBox(height: 8),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      controller.justificatifUrls.length,
                      (index) {
                        final url = controller.justificatifUrls[index];
                        return Chip(
                          label: Text(url.split('/').last),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted:
                              () => controller.retirerJustificatif(index),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: List.generate(
                        controller.photos.length,
                        (index) {
                          final image = controller.photos[index];
                          return Stack(
                            alignment: Alignment.topRight,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  image,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 2,
                                right: 2,
                                child: GestureDetector(
                                  onTap: () => controller.retirerPhoto(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black54,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        icon: const Icon(Icons.camera_alt),
                        label: const Text("Photographier"),
                        onPressed:
                            controller.isUploading.value
                                ? null
                                : () async {
                                  await controller.prendrePhotoEtAjouter();
                                },
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Fichiers"),
                        onPressed:
                            controller.isUploading.value
                                ? null
                                : () async {
                                  await controller.choisirFichiersEtAjouter();
                                },
                      ),
                    ],
                  ),
                  if (controller.isUploading.value)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: LinearProgressIndicator(),
                    ),
                ],
              );
            }),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                final String justification = motifController.text.trim();
                if (justification.isEmpty) {
                  Get.snackbar("Erreur", "Veuillez saisir un motif.");
                  return;
                }
                if (controller.justificatifUrls.isEmpty) {
                  Get.snackbar(
                    "Erreur",
                    "Veuillez ajouter au moins un justificatif.",
                  );
                  return;
                }
                await controller.ajouterJustificatif(
                  absenceId: absence['id'],
                  justification: justification,
                  message: "Justification d'une absence",
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
