import 'package:flutter/material.dart';
import 'package:frontend_flutter/screens/etudiant/connexion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _loadSplash() async {
    await Future.delayed(const Duration(seconds: 3)); 
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _loadSplash(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashContent();
          } else {
            return const ISMLoginApp(); 
          }
        },
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF462A1D),
      body: Center(
        child: Image.asset(
          'assets/logo.png', 
          width: 150,
        ),
      ),
    );
  }
}
