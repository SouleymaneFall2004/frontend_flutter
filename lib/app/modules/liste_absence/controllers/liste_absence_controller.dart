import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../global/user_controller.dart';

class ListeAbsenceController extends GetxController {
  final absences = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  final selectedStartDate = Rxn<DateTime>();
  final selectedEndDate = Rxn<DateTime>();

  @override
  void onReady() {
    super.onReady();
    fetchAbsences();
  }

  Future<void> fetchAbsences() async {
    final userId = Get.find<UserController>().user.value?['id'];
    if (userId == null) return;

    isLoading.value = true;
    final response = await http.get(
      Uri.parse('https://dev-back-end-sd0s.onrender.com/api/mobile/absences/etudiant/$userId'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List data = json['data'];
      absences.assignAll(data.cast<Map<String, dynamic>>());
      filterAbsencesByDate();
    } else {
      absences.clear();
    }
    isLoading.value = false;
  }

  Future<void> fetchAbsencesByEtat(String etat) async {
    final userId = Get.find<UserController>().user.value?['id'];
    if (userId == null) return;

    isLoading.value = true;
    final response = await http.get(
      Uri.parse('https://dev-back-end-sd0s.onrender.com/api/mobile/absences/etudiant/etat/$etat?etudiantId=$userId'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List data = json['data'];
      absences.assignAll(data.cast<Map<String, dynamic>>());
      filterAbsencesByDate();
    } else {
      absences.clear();
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
