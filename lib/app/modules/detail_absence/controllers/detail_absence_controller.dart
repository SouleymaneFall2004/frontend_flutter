import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/api.dart';
import '../../accueil/views/accueil_view.dart';

class DetailAbsenceController extends GetxController {
  final apiService = Api();

  // Liste dynamique des URLs des pièces jointes uploadées
  final RxList<String> justificatifUrls = <String>[].obs;

  final RxList<File> photos = <File>[].obs;

  // Pour afficher l’état de chargemen
  final RxBool isUploading = false.obs;

  // Méthode pour prendre une photo et l’ajouter à la liste
  Future<void> prendrePhotoEtAjouter() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      photos.add(File(image.path));
      Get.snackbar('Succès', "Photo ajoutée !");
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
            justificatifUrls.add(file.path!); // This will store the full file path
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

  // upload vers Firebase Storage
  Future<String> _uploadFileToFirebase(File file, String filename) async {
    String uniqueName = '${DateTime.now().millisecondsSinceEpoch}_$filename';
    Reference ref = FirebaseStorage.instance.ref().child(
      'justifications/$uniqueName',
    );
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  void retirerJustificatif(int index) {
    justificatifUrls.removeAt(index);
  }

  void retirerPhoto(int index) {
    photos.removeAt(index);
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
        Get.snackbar(
          "Erreur",
          "Impossible d'envoyer le justificatif : ${response.statusCode}",
        );
      }
    } catch (e) {
      Get.snackbar("Exception", "Une erreur s'est produite : $e");
    }
  }
}
