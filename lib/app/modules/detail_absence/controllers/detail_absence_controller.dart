import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../../../services/api.dart';
import '../../../../services/hive_db.dart';
import '../../accueil/views/accueil_view.dart';

class DetailAbsenceController extends GetxController {
  final apiService = Api();
  final token = HiveDb().getToken(); // 🔐 On récupère le token

  final RxList<String> justificatifUrls = <String>[].obs;
  final RxList<File> photos = <File>[].obs;
  final RxBool isUploading = false.obs;

  Future<void> prendrePhotoEtAjouter() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photos.add(File(image.path));
      Get.snackbar('Succès', "Photo ajoutée !");
    }
  }

  Future<void> choisirFichiersEtAjouter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if (result != null) {
      isUploading.value = true;
      try {
        for (var file in result.files) {
          if (file.path != null) {
            justificatifUrls.add(file.path!);
          }
        }
        Get.snackbar('Succès', "Fichiers ajoutés localement !");
      } catch (e) {
        Get.snackbar('Erreur', "Erreur lors de l'ajout local : $e");
      } finally {
        isUploading.value = false;
      }
    }
  }

  void retirerJustificatif(int index) {
    justificatifUrls.removeAt(index);
  }

  void retirerPhoto(int index) {
    photos.removeAt(index);
  }

  Future<void> uploadPhotosVersBackend() async {
    for (var photo in photos) {
      try {
        var uri = Uri.parse("https://dev-back-end-sd0s.onrender.com/api/images/upload");
        var request = http.MultipartRequest('POST', uri);

        // Ajout de l'entête avec le token
        request.headers['Authorization'] = 'Bearer $token';

        debugPrint('token : $token');

        request.files.add(
          await http.MultipartFile.fromPath('file', photo.path),
        );

        debugPrint('➡️ Uploading: ${photo.path}');
        debugPrint('➡️ Headers: ${request.headers}');
        debugPrint('➡️ Files: ${request.files}');


        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final url = data['url'] ?? data['data']; // adapter selon le format
          justificatifUrls.add(url);
        } else {
          debugPrint("Échec de lupload de ${photo.path} ${response.statusCode}");
          Get.snackbar("Erreur", "Échec de l’upload de ${photo.path} ${response.statusCode}");
        }
      } catch (e) {
        Get.snackbar("Erreur", "Erreur upload photo : $e");
      }
    }
  }

  Future<void> ajouterJustificatif({
    required String absenceId,
    required String justification,
    required String message,
  }) async {
    isUploading.value = true;

    // 1. Uploader toutes les photos d’abord
    await uploadPhotosVersBackend();

    final endpoint = "/api/mobile/absences/evenements/$absenceId/justificatif";
    try {
      final response = await apiService.post(
        endpoint, headers: {'Authorization': 'Bearer $token'},
        body: jsonEncode({
          "justification": justification,
          "message": message,
          "justificatifs": justificatifUrls.toList(),
        }),
      );

      if (response.statusCode == 200) {
        Get.offAll(() => const AccueilView(), transition: Transition.rightToLeft);
        justificatifUrls.clear();
        photos.clear();
      } else {
        Get.snackbar("Erreur", "Impossible d'envoyer le justificatif : ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", "Une erreur s'est produite : $e");
    } finally {
      isUploading.value = false;
    }
  }
}
