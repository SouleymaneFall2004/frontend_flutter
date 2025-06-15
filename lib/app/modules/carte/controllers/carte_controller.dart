import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class CarteController extends GetxController {
  late final MapController mapController;
  final currentPosition = Rxn<LatLng>();
  bool isMapReady = false;

  final ismPosition = const LatLng(14.6928, -17.4467);

  @override
  void onInit() {
    super.onInit();
    mapController = MapController();
    _determinePosition();
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
  }

  void goToISMLocation() {
    if (isMapReady) {
      mapController.move(ismPosition, 17);
    }
  }

  void goToCurrentLocation() {
    final pos = currentPosition.value;
    if (isMapReady && pos != null) {
      mapController.move(pos, 17);
    }
  }
}