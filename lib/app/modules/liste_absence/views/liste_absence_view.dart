import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/hive_db.dart';
import '../../../routes/app_pages.dart';
import '../controllers/liste_absence_controller.dart';

class ListeAbsenceView extends GetView<ListeAbsenceController> {
  const ListeAbsenceView({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedEtat = 'Tout';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Période",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          controller.selectedStartDate.value = date;
                          controller.filterAbsencesByDate();
                        }
                      },
                      child: Text(
                        controller.selectedStartDate.value != null
                            ? 'Du ${controller.selectedStartDate.value!.toLocal().toString().split(' ')[0]}'
                            : 'Date début',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (date != null) {
                          controller.selectedEndDate.value = date;
                          controller.filterAbsencesByDate();
                        }
                      },
                      child: Text(
                        controller.selectedEndDate.value != null
                            ? 'au ${controller.selectedEndDate.value!.toLocal().toString().split(' ')[0]}'
                            : 'Date fin',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text("Etat", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedEtat,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              items: ['Tout', 'Justifié', 'Non Justifié']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                selectedEtat = value;
                controller.filterAbsencesByEtat(value ?? 'Tout');
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                final hasNoLocalData = HiveDb().getData('absences') == null;

                if (controller.isLoading.value || hasNoLocalData) {
                  return FutureBuilder(
                    future: Future.delayed(const Duration(seconds: 2)),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (controller.absences.isEmpty) {
                        return const Center(
                            child: Text("Aucune absence trouvée."));
                      }

                      return ListView.builder(
                        itemCount: controller.absences.length,
                        itemBuilder: (context, index) {
                          final absence = controller.absences[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              leading: const CircleAvatar(
                                  child: Icon(Icons.person)),
                              title: Text(
                                "Absence du ${absence['dateDebut'] ?? '---'}",
                              ),
                              subtitle: Text(
                                "${absence['heureDebut']} - ${absence['heureFin']} • ${_formatEtat(
                                    absence['etat'])}",
                              ),
                              onTap: absence['etat'] == 'NOJUSTIFIE'
                                  ? () {
                                Get.toNamed(
                                  Routes.DETAIL_ABSENCE,
                                  arguments: absence,
                                );
                              }
                                  : null,
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                if (controller.absences.isEmpty) {
                  return const Center(child: Text("Aucune absence trouvée."));
                }

                return ListView.builder(
                  itemCount: controller.absences.length,
                  itemBuilder: (context, index) {
                    final absence = controller.absences[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.person)),
                        title: Text(
                          "Absence du ${absence['dateDebut'] ?? '---'}",
                        ),
                        subtitle: Text(
                          "${absence['heureDebut']} - ${absence['heureFin']} • ${_formatEtat(absence['etat'])}",
                        ),
                        onTap: absence['etat'] == 'NOJUSTIFIE'
                            ? () {
                                Get.toNamed(
                                  Routes.DETAIL_ABSENCE,
                                  arguments: absence,
                                );
                              }
                            : null,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatEtat(String? etat) {
  switch (etat) {
    case 'JUSTIFIE':
      return 'Justifié';
    case 'NOJUSTIFIE':
      return 'Non Justifié';
    case 'ENCOURS':
      return 'En cours';
    default:
      return etat ?? '';
  }
}
