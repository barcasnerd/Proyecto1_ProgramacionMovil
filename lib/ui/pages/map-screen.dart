import 'package:exercise_tracker/ui/controllers/map-view-controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                  ? const Center(child: Text("Loading"))
                  : Center(
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.all(windowHeight * 0.01),
                            child: SizedBox(
                              width: windowWidth * 0.98,
                              height: windowHeight * 0.98,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Obx(() => GoogleMap(
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
                                                    .currentLocation!.latitude!,
                                                mapViewController
                                                    .currentLocation!
                                                    .longitude!),
                                          ),
                                          Marker(
                                            markerId: MarkerId("source"),
                                            position: mapViewController
                                                .sourceLocation,
                                          ),
                                          Marker(
                                            markerId: MarkerId("destination"),
                                            position:
                                                mapViewController.destination,
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
                          )
                        ],
                      ),
                    ));
        });
  }
}
