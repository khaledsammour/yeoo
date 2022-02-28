import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';

class LocationDialogViewModel extends GetxController {
  GoogleMapController? mapController;
  var myMarker = HashSet<Marker>();
  double vlatitude = 32.17508293529325,
      vlongitude = 35.84746330976486,
      zoom = 10;
  double? currentLatiude, currentLongtiude;

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
  }

  void onMapCreated() {
    myMarker.add(Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.17508293529325, 35.84746330976486)));
    update();
  }

  getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
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
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    await Geolocator.getCurrentPosition().then((Position position) {
      myMarker.clear();

      myMarker.add(Marker(
          markerId: MarkerId('1'),
          position: LatLng(position.latitude, position.longitude)));

      currentLatiude = position.latitude;
      currentLongtiude = position.longitude;
      zoom = 4;
    });
  }

  onCameraMove(latitude, longitude) {
    myMarker.clear();
    myMarker.add(
        Marker(markerId: MarkerId('1'), position: LatLng(latitude, longitude)));

    update();
  }

  moveCamera(latitude, longitude, zoom) {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: zoom)));
  }
}
