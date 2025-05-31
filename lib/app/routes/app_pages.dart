import 'package:get/get.dart';

import '../modules/accueil/bindings/accueil_binding.dart';
import '../modules/accueil/views/accueil_view.dart';
import '../modules/connexion/bindings/connexion_binding.dart';
import '../modules/connexion/views/connexion_view.dart';
import '../modules/detail_absence/bindings/detail_absence_binding.dart';
import '../modules/detail_absence/views/detail_absence_view.dart';
import '../modules/detail_etudiant/bindings/detail_etudiant_binding.dart';
import '../modules/detail_etudiant/views/detail_etudiant_view.dart';
import '../modules/liste_absence/bindings/liste_absence_binding.dart';
import '../modules/liste_absence/views/liste_absence_view.dart';
import '../modules/pointage/bindings/pointage_binding.dart';
import '../modules/pointage/views/pointage_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CONNEXION;

  static final routes = [
    GetPage(
      name: _Paths.LISTE_ABSENCE,
      page: () => const ListeAbsenceView(),
      binding: ListeAbsenceBinding(),
    ),
    GetPage(
      name: _Paths.ACCUEIL,
      page: () => const AccueilView(),
      binding: AccueilBinding(),
    ),
    GetPage(
      name: _Paths.CONNEXION,
      page: () => const ConnexionView(),
      binding: ConnexionBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ABSENCE,
      page: () => const DetailAbsenceView(),
      binding: DetailAbsenceBinding(),
    ),
    GetPage(
      name: _Paths.POINTAGE,
      page: () => const PointageView(),
      binding: PointageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ETUDIANT,
      page: () => const DetailEtudiantView(),
      binding: DetailEtudiantBinding(),
    ),
  ];
}
