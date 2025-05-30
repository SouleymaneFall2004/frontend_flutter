import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/vigile/connexion.dart';
import 'screens/vigile/pointage.dart';
import 'screens/vigile/detail_etudiant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/pointage',
      getPages: [
        GetPage(name: '/', page: () => const ISMLoginApp()),
        GetPage(name: '/pointage', page: () => const PointageScreen()),
        GetPage(name: '/details', page: () => const DetailsEtudiantScreen()),
      ],
    );
  }
}
