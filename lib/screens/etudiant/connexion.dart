import 'package:flutter/material.dart';

import 'accueil.dart';

void main() {
  runApp(const ISMLoginApp());
}

class ISMLoginApp extends StatelessWidget {
  const ISMLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISM Login',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: -10,
              left: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF4B2E1D),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: -60,
              left: 0,
              child: Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Identifiant',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'abdoulayely@ism.edu.sn',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mot de passe',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Mot de Passe oublié?',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B2E1D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AccueilPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Se Connecter',
                          style: TextStyle(color: Colors.orange),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
