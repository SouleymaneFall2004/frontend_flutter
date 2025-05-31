import 'package:get/get.dart';
import '../modules/vigile/accueil/views/vigile_accueil_view.dart';
import '../modules/vigile/accueil/bindings/vigile_accueil_binding.dart';

import '../modules/vigile/connexion/views/vigile_connexion_view.dart';
import '../modules/vigile/connexion/bindings/vigile_connexion_binding.dart';

import '../modules/vigile/pointage/views/vigile_pointage_view.dart';
import '../modules/vigile/pointage/bindings/vigile_pointage_binding.dart';

import '../modules/vigile/detail_etudiant/views/vigile_detail_etudiant_view.dart';
import '../modules/vigile/detail_etudiant/bindings/vigile_detail_etudiant_binding.dart';

class AppPages {
  static const initial = '/vigile-accueil';

  static final routes = [
    GetPage(
      name: '/vigile-accueil',
      page: () => const VigileAccueilView(),
      binding: VigileAccueilBinding(),
    ),
    GetPage(
      name: '/vigile-connexion',
      page: () => const VigileConnexionView(),
      binding: VigileConnexionBinding(),
    ),
    GetPage(
      name: '/vigile-pointage',
      page: () => const VigilePointageView(),
      binding: VigilePointageBinding(),
    ),
    GetPage(
      name: '/vigile-detail-etudiant',
      page: () => const VigileDetailEtudiantView(),
      binding: VigileDetailEtudiantBinding(),
    ),
  ];
}
