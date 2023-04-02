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
          return Scaffold(
              body: mapViewController.currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.all(windowHeight * 0.01),
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
                                                    .currentLocation!.latitude!,
                                                mapViewController
                                                    .currentLocation!
                                                    .longitude!),
                                            zoom: mapViewController.cameraZoom),
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
                                          mapViewController.controller
                                              .complete(controller);
                                        },
                                        polylines: {
                                          Polyline(
                                            polylineId: PolylineId("route"),
                                            points: mapViewController
                                                .polylineCoordinates.value,
                                            color: Color(0xff09fba5),
                                            width: 8,
                                          ),
                                        },
                                      )),
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () =>
                                  {Navigator.popAndPushNamed(snap, '/home')},
                              child: Text('Back')),
                        ],
                      ),
                    ));
        });
  }
}
