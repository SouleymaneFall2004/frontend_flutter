import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../accueil/views/accueil_view.dart';
import '../../../../services/api_service.dart';

class DetailAbsenceController extends GetxController {
  final apiService = ApiService();

  // Liste dynamique des URLs des pièces jointes uploadées
  final RxList<String> justificatifUrls = <String>[].obs;

  // Pour afficher l’état de chargement
  final RxBool isUploading = false.obs;

  // Méthode pour prendre une photo et l’ajouter à la liste
  Future<void> prendrePhotoEtAjouter() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      isUploading.value = true;
      try {
        String url = await _uploadFileToFirebase(File(image.path), image.name);
        justificatifUrls.add(url);
        Get.snackbar('Succès', "Photo ajoutée !");
      } catch (e) {
        Get.snackbar('Erreur', "Erreur lors de l'upload de la photo : $e");
      } finally {
        isUploading.value = false;
      }
    }
  }

  // sélectionner plusieurs fichiers et les ajouter à la liste
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
            String url = await _uploadFileToFirebase(File(file.path!), file.name);
            justificatifUrls.add(url);
          }
        }
        Get.snackbar('Succès', "Fichiers ajoutés !");
      } catch (e) {
        Get.snackbar('Erreur', "Erreur lors de l'upload : $e");
      } finally {
        isUploading.value = false;
      }
    }
  }

  // upload vers Firebase Storage
  Future<String> _uploadFileToFirebase(File file, String filename) async {
    String uniqueName = '${DateTime.now().millisecondsSinceEpoch}_$filename';
    Reference ref = FirebaseStorage.instance.ref().child('justifications/$uniqueName');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }


  void retirerJustificatif(int index) {
    justificatifUrls.removeAt(index);
  }

  Future<void> ajouterJustificatif({
    required String absenceId,
    required String justification,
    required String message,
  }) async {
    final endpoint = "/api/mobile/absences/evenements/$absenceId/justificatif";
    try {
      final response = await apiService.post(
        endpoint,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "justification": justification,
          "message": message,
          "justificatifs": justificatifUrls.toList(),
        }),
      );

      if (response.statusCode == 200) {
        Get.offAll(
              () => const AccueilView(),
          transition: Transition.rightToLeft,
        );
        justificatifUrls.clear();
      } else {
        Get.snackbar("Erreur", "Impossible d'envoyer le justificatif : ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Exception", "Une erreur s'est produite : $e");
    }
  }
}