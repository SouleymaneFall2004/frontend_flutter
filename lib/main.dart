import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/vigile/connexion.dart';
import 'package:frontend_flutter/screens/vigile/pointage.dart';
import 'package:frontend_flutter/utils/const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISM Absence',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ISMLoginApp(),
        '/pointage': (context) => const PointageScreen(),
      },
    );
  }
}
