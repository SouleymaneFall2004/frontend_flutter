import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

import '../../../../services/api.dart';

class CarteController extends GetxController {
  late final MapController mapController;
  final currentPosition = Rxn<LatLng>();
  bool isMapReady = false;
  final apiService = Api();

  final ismPosition = const LatLng(14.6928, -17.4467);
  final markers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    _determinePosition();
    ajouterMarqueurISM();
  }

  void onMapReady() {
    isMapReady = true;
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition();
    currentPosition.value = LatLng(position.latitude, position.longitude);
    ajouterMarqueurPositionActuelle();
  }

  void goToISMLocation() {
    if (isMapReady) {
      final ismCoords = LatLng(14.690577, -17.457692);
      mapController.move(ismCoords, 19);
    }
  }

  void goToCurrentLocation() {
    final pos = currentPosition.value;
    if (isMapReady && pos != null) {
      mapController.move(pos, 17);
    }
  }

  void ajouterMarqueurPositionActuelle() {
    final pos = currentPosition.value;
    if (pos != null) {
      markers.add(
        Marker(
          point: pos,
          width: 40,
          height: 40,
          child: const Icon(Icons.my_location, color: Colors.blue, size: 30),
        ),
      );
    }
  }

  void ajouterMarqueurISM() {
    markers.add(
      Marker(
        point: ismPosition,
        width: 40,
        height: 40,
        child: const Icon(Icons.school, color: Colors.deepOrange, size: 30),
      ),
    );
  }
}
