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

  List<LatLng> polylineCoordinatesWrapper = [];
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

  Rx<bool> locationServiceEnabled = false.obs;
  Rx<bool> locationPermissionEnabled = false.obs;

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
      logInfo('[getStartingPosition]: Init polilynepoints');
      sourceLocation = LatLng(showableCurrentLocation.value.latitude,
          showableCurrentLocation.value.longitude);
      polylineCoordinates.value.add(sourceLocation);
      polylineCoordinatesWrapper.add(sourceLocation);
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
      logInfo('[getStartingPosition]: Update polilynepoints');
      polylineCoordinates.value.add(LatLng(
          showableCurrentLocation.value.latitude,
          showableCurrentLocation.value.longitude));
    });
    logInfo('[getCurrentLocation]: Finished');
  }

  Future<void> checkPermission() async {
    logInfo('[checkPermission]: Init');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        locationPermissionEnabled.value = false;
        logWarning('[checkPermission]: Location permission denied');
      } else {
        locationPermissionEnabled.value = true;
      }
    }
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationServiceEnabled.value = false;
      logWarning('[checkPermission]: Location services are disabled');
    } else {
      locationServiceEnabled.value = true;
    }
    logInfo('[checkPermission]: Finished');
  }

  Future<void> resetControllerVariables() async {
    logInfo('[resetControllerVariables]: Init');
    logInfo('[resetControllerVariables]: Reset current location');
    currentLocation = null;
    polylineCoordinates.value.clear();
    logInfo('[resetControllerVariables]: Reset google map controller');
    logInfo('[resetControllerVariables]: Finished');
  }

  Future<void> closePositionStream() async {
    logInfo('[closePositionStream]: Init');
    await _locationSubscription!.cancel();
    _locationSubscription!.pause();
    logDebug(_locationSubscription.isBlank);
    logDebug(_locationSubscription!.isPaused);
    logInfo('[closePositionStream]: Finished');
  }

  Future<void> main() async {
    logInfo('[main]: Init');
    //await getPolyPoints();
    await checkPermission();
    await getStartingPosition();
    await getCurrentLocation();
    logInfo('[main]: Finished');
  }

  Future<void> close() async {
    logInfo('[close]: Init');
    await resetControllerVariables();
    await closePositionStream();
    //await Get.delete<MapViewController>();
    logInfo('[close]: Finished');
  }
}
