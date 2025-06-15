import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/carte_controller.dart';

class CarteView extends GetView<CarteController> {
  const CarteView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CarteController());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller.mapController,
            options: MapOptions(
              onMapReady: controller.onMapReady,
              initialCenter: LatLng(14.6928, -17.4467),
              initialZoom: 15,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: FloatingActionButton(
              heroTag: "goToISM",
              onPressed: controller.goToISMLocation,
              backgroundColor: Color(0xFF4B2E1D),
              child: const Icon(Icons.school, color: Colors.orange,),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: FloatingActionButton(
              heroTag: "goToCurrent",
              onPressed: controller.goToCurrentLocation,
              backgroundColor: Color(0xFF4B2E1D),
              child: const Icon(Icons.my_location, color: Colors.orange,),
            ),
          ),
        ],
      ),
    );
  }
}
