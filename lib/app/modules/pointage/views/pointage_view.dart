// lib/screens/qr_scanner_screen.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/app/modules/detail_etudiant/views/detail_etudiant_view.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
        title: Text('Scanner QR Code'),
        backgroundColor: Colors.brown,
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
                Positioned.fill(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Scannez le code QR de l\'étudiant',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
      // Appeler votre API pour vérifier le matricule
      // Exemple: final student = await StudentService.verifyStudent(code);

      // Pour la démo, on simule une réponse
      await Future.delayed(Duration(seconds: 1));
      final studentData = {
        'matricule': code,
        'nom': 'Abdoulaye Ly',
        'dateNaissance': '19/06/1999',
        'classe': 'L3GLRS',
      };

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailEtudiantView(studentData: studentData),
        ),
      ).then((_) {
        isScanning = true;
        controller?.resumeCamera();
      });
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
