import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  final CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025), zoom: 10.0);

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: FutureBuilder(
      future: _determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                child: Text('Erorr'),
              ));
        } else {
          return Column(
            children: [
              Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('back')),
                  Center(
                    child: Column(
                      children: [
                        Text('Running Route'),
                        Text(
                            'Press the start button and stop whenever\nyou want to finish your session')
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: windowWidth * 0.95,
                    height: windowHeight * 0.68,
                    child: Center(
                      child: GoogleMap(
                        onMapCreated: (controller) {
                          controller.setMapStyle(
                              ' [{"featureType":"poi","stylers":[{"visibility":"off"}]}]');
                        },
                        mapType: MapType.none,
                        zoomControlsEnabled: false,
                        buildingsEnabled: false,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(snapshot.data?.latitude ?? 10.963889,
                                snapshot.data?.longitude ?? -74.796387),
                            zoom: 15.0),
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        }
      },
    ));
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
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
    return await Geolocator.getCurrentPosition();
  }
}
