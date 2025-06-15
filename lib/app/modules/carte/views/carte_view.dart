import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/carte_controller.dart';

class CarteView extends GetView<CarteController> {
  const CarteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CarteView'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (controller.currentPosition.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }

            return GoogleMap(
              key: const ValueKey('google_map'), // Pour éviter le crash view id
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  controller.currentPosition.value!.latitude,
                  controller.currentPosition.value!.longitude,
                ),
                zoom: 15,
              ),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              markers: controller.markers,
              onMapCreated: (GoogleMapController mapController) {
                if (controller.mapController.value == null) {
                  controller.mapController.value = mapController;
                }
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.centerMapOnCurrentPosition,
        backgroundColor: Colors.green,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
