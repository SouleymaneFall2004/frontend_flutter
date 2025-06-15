import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarteController extends GetxController {
  final currentPosition = Rxn<Position>();
  final mapController = Rxn<GoogleMapController>();
  final markers = <Marker>{}.obs;

  final ismPosition = const LatLng(14.6928, -17.4467); // Replace with actual ISM coords

  @override
  void onInit() {
    super.onInit();
    determinePosition();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    final position = await Geolocator.getCurrentPosition();
    currentPosition.value = position;

    addISMMarker();
    addCurrentPositionMarker();
  }

  void addISMMarker() {
    markers.add(
      Marker(
        markerId: const MarkerId("ism"),
        position: ismPosition,
        infoWindow: const InfoWindow(title: "ISM Digital Campus"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  void addCurrentPositionMarker() {
    final pos = currentPosition.value;
    if (pos != null) {
      markers.add(
        Marker(
          markerId: const MarkerId("current"),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: const InfoWindow(title: "Votre position"),
        ),
      );
    }
  }

  Future<void> centerMapOnCurrentPosition() async {
    final controller = mapController.value;
    final pos = currentPosition.value;
    if (controller != null && pos != null) {
      await controller.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(pos.latitude, pos.longitude),
        ),
      );
    }
  }
}
