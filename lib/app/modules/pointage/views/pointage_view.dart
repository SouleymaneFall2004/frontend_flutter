// lib/screens/qr_scanner_screen.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/app/modules/detail_etudiant/views/detail_etudiant_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../routes/app_pages.dart';

class PointageView extends StatefulWidget {
  const PointageView({super.key});

  @override
  State<StatefulWidget> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<PointageView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool isScanning = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Get.offAllNamed(Routes.CONNEXION);
          },
        ),
        title: Text('Scanner QR Code', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF4B2E1D),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.orange,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 16,
                  right: 16,
                  child: SafeArea(
                    child: TextField(
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
                          _processQRCode(jsonEncode({'matricule': value}));
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

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (isScanning && scanData.code != null) {
        isScanning = false;
        _processQRCode(scanData.code!);
      }
    });
  }

  void _processQRCode(String code) async {
    try {
      final decoded = jsonDecode(code);
      final matricule = decoded['matricule'];

      final response = await http.get(
        Uri.parse(
          'https://dev-back-end-sd0s.onrender.com/api/mobile/etudiants/$matricule',
        ),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final studentData = decoded['data'][0];

        final user = studentData;
        final etudiantId = user['etudiantId'];
        final vigileId = user['vigileId'];

        try {
          final pointageResponse = await http.get(
            Uri.parse(
              'https://dev-back-end-sd0s.onrender.com/api/mobile/pointages/create?etudiantId=$etudiantId&vigileId=$vigileId',
            ),
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
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erreur lors du pointage'),
              backgroundColor: Colors.red,
            ),
          );
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailEtudiantView(studentData: studentData),
          ),
        ).then((_) {
          isScanning = true;
          controller?.resumeCamera();
        });
      } else {
        throw Exception("Étudiant non trouvé");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: Étudiant non trouvé'),
          backgroundColor: Colors.red,
        ),
      );
      isScanning = true;
      controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
