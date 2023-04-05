import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:loggy/loggy.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart' as painting;

import 'home_controller.dart';

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

  Rx<bool> locationServiceEnabled = true.obs;
  Rx<bool> locationPermissionEnabled = true.obs;

  Rx<BitmapDescriptor> currentLocationIcon = BitmapDescriptor.defaultMarker.obs;

  static HomeController homeController = Get.put(HomeController());

  Rx<bool> isRecording = false.obs;

  var stopwatch;
  Rx<Duration> elapsedTime = Rx<Duration>(Duration.zero);
  var seconds = 0.obs;
  var minutes = 0.obs;
  var hours = 0.obs;

  geo.Position? pasterLocation;
  geo.Position? futureLocation;

  double currentDistance = 0.0;
  Rx<String> showableDistance = (0.0).toStringAsFixed(2).obs;

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
      logInfo('[getStartingPosition]: asing paster location');
      pasterLocation = position;
      logInfo('[getStartingPosition]: asing future location');
      futureLocation = position;
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
      logInfo('[getStartingPosition]: asing paster location');
      pasterLocation = futureLocation;
      logInfo('[getStartingPosition]: asing future location');
      futureLocation = newLoc;
      logInfo('[getStartingPosition]: calculate distance');
      var distance = distanceInKm(
          pasterLocation!.latitude,
          pasterLocation!.longitude,
          futureLocation!.latitude,
          futureLocation!.longitude);
      logDebug(distance);
      currentDistance = currentDistance + distance;
      logInfo('[getStartingPosition]: showable distance in km');
      showableDistance.value = currentDistance.toStringAsFixed(2);
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
    } else {
      locationPermissionEnabled.value = true;
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

  Future<Uint8List> getBytesFromAssetRadius(String path, int width) async {
    final data = await rootBundle.load(path);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    final frame = await codec.getNextFrame();
    final byteData =
        await frame.image.toByteData(format: ui.ImageByteFormat.png);

    // Create a new PictureRecorder
    final recorder = ui.PictureRecorder();

    // Create a Canvas with the recorder
    final canvas = ui.Canvas(recorder);

    // Get the width and height of the image
    final imageWidth = frame.image.width.toDouble();
    final imageHeight = frame.image.height.toDouble();

    // Calculate the radius of the circle based on the larger dimension of the image
    final circleRadius =
        (imageWidth > imageHeight ? imageWidth : imageHeight) / 2;

    // Draw a white circle with the calculated radius
    canvas.drawCircle(ui.Offset(circleRadius, circleRadius), circleRadius,
        ui.Paint()..color = const Color(0xff09fba5));

    // Draw the image in the center of the circle
    canvas.drawImage(
        frame.image,
        ui.Offset(
            circleRadius - (imageWidth / 2), circleRadius - (imageHeight / 2)),
        ui.Paint());

    // End the recording and create a Picture object
    final picture = recorder.endRecording();

    // Convert the Picture to a PNG-encoded ByteData
    var pngBytes1 = await picture.toImage(
        circleRadius.toInt() * 2, circleRadius.toInt() * 2);
    final pngBytes = await pngBytes1.toByteData(format: ui.ImageByteFormat.png);

    return pngBytes!.buffer.asUint8List();
  }

  Future<void> setCustomMarkerIcon() async {
    final Uint8List markerIcon = await getBytesFromAssetRadius(
        homeController.activityType.value == 'bike'
            ? 'assets/images/bike_logo.png'
            : 'assets/images/run_logo.png',
        150);
    currentLocationIcon.value = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<void> resetControllerVariables() async {
    logInfo('[resetControllerVariables]: Init');
    logInfo('[resetControllerVariables]: Reset current location');
    currentLocation = null;
    polylineCoordinates.value.clear();
    logInfo('[resetControllerVariables]: reset showable variables');
    seconds = 0.obs;
    minutes = 0.obs;
    hours = 0.obs;
    currentDistance = 0;
    showableDistance = (0.0).toStringAsFixed(2).obs;
    logInfo('[resetControllerVariables]: reset stopwatch');
    await stopwatch.reset();
    logInfo('[resetControllerVariables]: stop stopwatch');
    await stopwatch.stop();
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

  Future<void> initStopWatch() async {
    logInfo('[initStopWatch]: Init');
    elapsedTime = Rx<Duration>(Duration.zero);
    stopwatch = Stopwatch();
    stopwatch.start();
    Timer.periodic(Duration(milliseconds: 100), (_) {
      if (stopwatch.isRunning) {
        elapsedTime.value = stopwatch.elapsed;
        int current = elapsedTime.value.inSeconds;
        seconds.value = (current as int) % 60;
        minutes.value = (current / 60).toInt() % 60;
        hours.value = (current / 3600).toInt();
      }
    });
    logInfo('[initStopWatch]: Finished');
  }

  Future<void> stopStopWatch() async {
    logInfo('[stopStopWatch]: Init');
    seconds = 0.obs;
    minutes = 0.obs;
    hours = 0.obs;
    await stopwatch.reset();
    await stopwatch.stop();
    logInfo('[stopStopWatch]: Finished');
  }

  double distanceInKm(lat1, long1, lat2, long2) {
    var R = 6371; // Radio de la Tierra en km
    var dLat = _degToRad(lat2 - lat1);
    var dLon = _degToRad(long2 - long1);
    var a = pow(sin(dLat / 2), 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * pow(sin(dLon / 2), 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c;
    return d;
  }

  double _degToRad(degrees) {
    return degrees * pi / 180;
  }

  Future<void> main() async {
    logInfo('[main]: Init');
    //await getPolyPoints();
    await checkPermission();
    await setCustomMarkerIcon();
    await getStartingPosition();
    //await getCurrentLocation();
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
