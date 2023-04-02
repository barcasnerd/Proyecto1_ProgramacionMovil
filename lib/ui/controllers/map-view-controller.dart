import 'dart:async';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:loggy/loggy.dart';

class MapViewController extends GetxController {
  final Completer<GoogleMapController> controller = Completer();

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

  Future<void> getCurrentLocation() async {
    geo.Position? position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high,
    );
    if (currentLocation != null) {
      currentLocation = position;
      showableCurrentLocation.value = currentLocation!;
      GoogleMapController googleMapController = await controller.future;
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
    }
    _locationSubscription = geo.Geolocator.getPositionStream(
            locationSettings: geo.LocationSettings(
                accuracy: geo.LocationAccuracy.best, distanceFilter: 10))
        .listen((newLoc) async {
      currentLocation = newLoc;
      showableCurrentLocation.value = currentLocation!;
      logDebug('🗺️Position change', currentLocation);
      GoogleMapController googleMapController = await controller.future;
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

  Future<void> main() async {
    await getPolyPoints();
    await checkPermission();
    await getCurrentLocation();
  }
}
