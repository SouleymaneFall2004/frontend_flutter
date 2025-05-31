import 'package:get/get.dart';

import '../modules/accueil/bindings/accueil_binding.dart';
import '../modules/accueil/views/accueil_view.dart';
import '../modules/connexion/bindings/connexion_binding.dart';
import '../modules/connexion/views/connexion_view.dart';
import '../modules/detail_absence/bindings/detail_absence_binding.dart';
import '../modules/detail_absence/views/detail_absence_view.dart';
import '../modules/liste_absence/bindings/liste_absence_binding.dart';
import '../modules/liste_absence/views/liste_absence_view.dart';

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
  ];
}
