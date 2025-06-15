import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../../../../services/api.dart';
import '../../../../services/hive_db.dart';

class ListeAbsenceController extends GetxController {
  final absences = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final selectedStartDate = Rxn<DateTime>();
  final selectedEndDate = Rxn<DateTime>();
  final selectedEtat = 'Tout'.obs;

  final apiService = Api();

  @override
  void onReady() {
    super.onReady();
    fetchAbsences();
  }

  Future<void> fetchAbsences() async {
    final userId = HiveDb().getUser()?['etudiantId'];
    final token = HiveDb().getToken();
    log(userId);
    log("token récupéré : $token");
    if (userId == null) return;

    isLoading.value = true;
    try {
      final token = HiveDb().getToken();

      final response = await apiService.get(
        '/api/mobile/absences/etudiant/$userId',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List data = json['data'];
        absences.assignAll(data.cast<Map<String, dynamic>>());
        if (absences.isNotEmpty) {
          log("Première absence : ${absences.first}");
          log("Dernière absence : ${absences.last}");
        } else {
          log("Aucune absence trouvée pour cet utilisateur.");
        }
        await HiveDb().saveData('absences', data.cast<Map<String, dynamic>>());
        filterAbsencesByEtat('Tout');
      } else {
        absences.clear();
        Get.snackbar('Erreur', 'Impossible de charger les absences.');
      }
    } catch (e) {
      absences.clear();
      Get.snackbar('Erreur', 'Une erreur est survenue : $e');
    }
    isLoading.value = false;
  }

  void filterAbsencesByEtat(String etat) {
    final allAbsences = HiveDb().getData('absences') ?? [];
    List<Map<String, dynamic>> filtered = List<Map<String, dynamic>>.from(
      allAbsences,
    );

    final etatMap = {
      'Justifié': 'JUSTIFIE',
      'Non Justifié': 'NOJUSTIFIE',
      'En attente': 'ENATTENTE',
    };

    if (etat != 'Tout') {
      final etatValeur = etatMap[etat];
      if (etatValeur != null) {
        filtered = filtered.where((a) => a['etat'] == etatValeur).toList();
      }
    }

    log("Absences après filtre état ($etat) : ${filtered.length}");
    if (filtered.isNotEmpty) {
      log("1st : ${filtered.first}");
    } else {
      log("Aucune absence après filtrage.");
    }

    absences.assignAll(filtered);
    filterAbsencesByDate();
  }

  void filterAbsencesByDate() {
    final start = selectedStartDate.value;
    final end = selectedEndDate.value;

    if (start == null || end == null) return;

    final filtered =
        absences.where((absence) {
          final dateStr = absence['dateDebut'] as String?;
          if (dateStr == null) return false;
          final date = DateTime.tryParse(dateStr);
          if (date == null) return false;
          return date.isAfter(start.subtract(const Duration(days: 1))) &&
              date.isBefore(end.add(const Duration(days: 1)));
        }).toList();

    absences.assignAll(filtered);
  }
}
