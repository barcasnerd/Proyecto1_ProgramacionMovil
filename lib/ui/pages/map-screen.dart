import 'package:exercise_tracker/ui/controllers/map-view-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

class MapScreen extends StatelessWidget {
  MapScreen({super.key});

  static MapViewController mapViewController = Get.put(MapViewController());

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<void>(
        future: mapViewController.main(),
        builder: (snap, context) {
          if (mapViewController.locationPermissionEnabled.value == false ||
              mapViewController.locationServiceEnabled.value == false) {
            if (mapViewController.locationPermissionEnabled.value == false) {
              return const Scaffold(
                body: Center(
                  child: Text('No se consedió permiso de ubicación'),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text('El servicio de ubicación está desactivado'),
                ),
              );
            }
          } else {
            return Scaffold(
                body: mapViewController.currentLocation == null
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            ElevatedButton(
                                onPressed: () async {
                                  await mapViewController.close();
                                },
                                child: Text('close'))
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.all(
                                  windowHeight * 0.01),
                              child: SizedBox(
                                width: windowWidth * 0.98,
                                height: windowHeight * 0.6,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Obx(() => GoogleMap(
                                          onLongPress: (argument) {
                                            Navigator.popAndPushNamed(
                                                snap, '/home');
                                          },
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  mapViewController
                                                      .currentLocation!
                                                      .latitude!,
                                                  mapViewController
                                                      .currentLocation!
                                                      .longitude!),
                                              zoom:
                                                  mapViewController.cameraZoom),
                                          markers: {
                                            Marker(
                                              markerId: const MarkerId(
                                                  "currentLocation"),
                                              position: LatLng(
                                                  mapViewController
                                                      .showableCurrentLocation!
                                                      .value
                                                      .latitude!,
                                                  mapViewController
                                                      .showableCurrentLocation!
                                                      .value
                                                      .longitude!),
                                            ),
                                          },
                                          onMapCreated: (controller) {
                                            mapViewController.controller =
                                                controller;
                                          },
                                          polylines: {
                                            Polyline(
                                              polylineId: PolylineId("route"),
                                              points: mapViewController
                                                  .polylineCoordinates.value,
                                              color: Color(0xff09fba5),
                                              width: 20,
                                            ),
                                          },
                                        )),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  mapViewController.close();
                                  Navigator.popAndPushNamed(snap, '/home');
                                },
                                child: Text('Back')),
                          ],
                        ),
                      ));
          }
        });
  }
}
