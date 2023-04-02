import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:loggy/loggy.dart';

class MapViewController extends GetxController {
  late GoogleMapController controller;

  LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  LatLng destination = LatLng(37.33429383, -122.06600055);

  double cameraZoom = 19;

  Rx<List<LatLng>> polylineCoordinates = Rx<List<LatLng>>([]);

  geo.Position? currentLocation;

  StreamSubscription<geo.Position>? _locationSubscription;

  Rx<Position> showableCurrentLocation = Position(
    latitude: 0,
    longitude: 0,
    altitude: 10.0,
    accuracy: 5.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    heading: 0.0,
    timestamp: DateTime.now(),
  ).obs;

  Future<void> getPolyPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "API_KEY",
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );
      if (result.points.isNotEmpty) {
        result.points.forEach(
          (PointLatLng point) => polylineCoordinates.value.add(
            LatLng(point.latitude, point.longitude),
          ),
        );
      }
      logInfo('✅ PolyLineCoordinates Retrieved');
    } catch (e) {
      logWarning('⚠️ Something failed with get polyline points');
    }
  }

  Future<void> getStartingPosition() async {
    try {
      logInfo('[getStartingPosition]: Getting Starting Position');
      geo.Position? position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      logDebug(position);
      logDebug(currentLocation);
      logInfo('[getStartingPosition]: Trying to assing location');
      currentLocation = position;
      showableCurrentLocation.value = currentLocation!;
      logInfo('[getStartingPosition]: Waiting for google map controller');
      GoogleMapController googleMapController = await controller;
      logInfo('[getStartingPosition]: Trying to animate camera');
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: cameraZoom,
            target: LatLng(
              position.latitude,
              position.longitude,
            ),
          ),
        ),
      );
      logInfo('[getStartingPosition]: Camera animated');
      logDebug(showableCurrentLocation);
      logInfo('[getStartingPosition]: Position got!');
    } catch (error) {
      logError(error);
    }
  }

  Future<void> getCurrentLocation() async {
    logInfo('[getCurrentLocation]: Init live location suscription');
    _locationSubscription = geo.Geolocator.getPositionStream(
            locationSettings: const geo.LocationSettings(
                accuracy: geo.LocationAccuracy.best, distanceFilter: 10))
        .listen((newLoc) async {
      logInfo(
          '[getCurrentLocation]: Assigning showable location from suscription');
      currentLocation = newLoc;
      showableCurrentLocation.value = currentLocation!;
      logDebug(currentLocation);
      logDebug(showableCurrentLocation.value);
      logInfo('[getCurrentLocation]: Waiting for google map controller');
      GoogleMapController googleMapController = await controller;
      logInfo('[getCurrentLocation]: Animating map camera');
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: cameraZoom,
            target: LatLng(
              newLoc.latitude,
              newLoc.longitude,
            ),
          ),
        ),
      );
    });
    logInfo('[getCurrentLocation]: Finished');
  }

  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        logWarning('⚠️ Location permission denied');
      }
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      logWarning('⚠️ Location services are disabled');
    }
  }

  Future<void> resetControllerVariables() async {
    logInfo('[resetControllerVariables]: Init');
    logInfo('[resetControllerVariables]: Reset current location');
    currentLocation = null;
    logInfo('[resetControllerVariables]: Reset google map controller location');
    logInfo('[resetControllerVariables]: Finished');
  }

  Future<void> closePositionStream() async {
    logInfo('[closePositionStream]: Init');
    await _locationSubscription!.cancel();
    logDebug(_locationSubscription.isBlank);
    logDebug(_locationSubscription!.isPaused);
    logInfo('[closePositionStream]: Finished');
  }

  Future<void> main() async {
    logInfo('[main]: Init');
    await getPolyPoints();
    await checkPermission();
    await getStartingPosition();
    await getCurrentLocation();
    logInfo('[main]: Finished');
  }

  Future<void> close() async {
    logInfo('[close]: Init');
    await resetControllerVariables();
    await closePositionStream();
    await Get.delete<MapViewController>();
    logInfo('[close]: Finished');
  }
}
