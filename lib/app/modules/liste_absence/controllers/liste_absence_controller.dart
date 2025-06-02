import 'dart:convert';
import 'package:get/get.dart';
import '../../../global/user_controller.dart';
import '../../../../services/api_service.dart';

class ListeAbsenceController extends GetxController {
  final absences = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final selectedStartDate = Rxn<DateTime>();
  final selectedEndDate = Rxn<DateTime>();

  final apiService = ApiService();

  @override
  void onReady() {
    super.onReady();
    fetchAbsences();
  }

  Future<void> fetchAbsences() async {
    final userId = Get.find<UserController>().user.value?['id'];
    if (userId == null) return;

    isLoading.value = true;
    try {
      final response = await apiService.get('/api/mobile/absences/etudiant/$userId');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List data = json['data'];
        absences.assignAll(data.cast<Map<String, dynamic>>());
        filterAbsencesByDate();
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

  Future<void> fetchAbsencesByEtat(String etat) async {
    final userId = Get.find<UserController>().user.value?['id'];
    if (userId == null) return;

    isLoading.value = true;
    try {
      final response = await apiService.get('/api/mobile/absences/etudiant/etat/$etat?etudiantId=$userId');
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List data = json['data'];
        absences.assignAll(data.cast<Map<String, dynamic>>());
        filterAbsencesByDate();
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

  void filterAbsencesByDate() {
    final start = selectedStartDate.value;
    final end = selectedEndDate.value;

    if (start == null || end == null) return;

    final filtered = absences.where((absence) {
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