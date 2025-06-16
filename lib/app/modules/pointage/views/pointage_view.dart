import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/app/modules/detail_etudiant/views/detail_etudiant_view.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../services/api.dart';
import '../../../../services/hive_db.dart';
import '../../../routes/app_pages.dart';

class PointageView extends StatefulWidget {
  const PointageView({super.key});

  @override
  State<PointageView> createState() => _PointageViewState();
}

class _PointageViewState extends State<PointageView> {
  bool isScanning = true;
  final apiService = Api();
  final TextEditingController _textController = TextEditingController();
  final MobileScannerController _scannerController = MobileScannerController();

  void _handleQRCode(String code) async {
    try {
      final decoded = jsonDecode(code);
      final matricule = decoded['matricule'];
      final token = HiveDb().getToken();

      final response = await apiService.get(
        '/api/mobile/etudiants/$matricule',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final studentData = decoded['data'][0];
        final etudiantId = studentData['id'];
        final vigileId = HiveDb().getUser()?['vigileId'];

        final pointageResponse = await apiService.get(
          '/api/mobile/pointages/create?etudiantId=$etudiantId&vigileId=$vigileId',
          headers: {'Authorization': 'Bearer $token'},
        );

        if (pointageResponse.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pointage effectué avec succès'),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Échec du pointage (${pointageResponse.statusCode})'),
              backgroundColor: Colors.red,
            ),
          );
        }

        Get.to(() => DetailEtudiantView(studentData: studentData))?.then((_) {
          isScanning = true;
          _scannerController.start();
        });
      } else {
        throw Exception("Étudiant non trouvé");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erreur: Étudiant non trouvé ou QR invalide"),
          backgroundColor: Colors.red,
        ),
      );
      isScanning = true;
      _scannerController.start();
    }
  }

  @override
  void dispose() {
    _scannerController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white, onPressed: () {
          Get.offAllNamed(Routes.CONNEXION);
        }),
        title: const Text('Scanner QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4B2E1D),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                MobileScanner(
                  controller: _scannerController,
                  onDetect: (capture) {
                    if (!isScanning) return;
                    final barcode = capture.barcodes.first;
                    final code = barcode.rawValue;
                    if (code != null) {
                      isScanning = false;
                      _scannerController.stop();
                      _handleQRCode(code);
                    }
                  },
                ),
                Positioned(
                  top: 20,
                  left: 16,
                  right: 16,
                  child: SafeArea(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Matricule...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          final fakeCode = jsonEncode({'matricule': value});
                          _handleQRCode(fakeCode);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}