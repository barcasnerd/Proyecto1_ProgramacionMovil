import 'dart:async';

import 'package:blurry/blurry.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

import '../controllers/home_controller.dart';
import '../controllers/map-view-controller.dart';

class RouteScreen extends StatelessWidget {
  RouteScreen({super.key});

  static HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    MapViewController mapViewController = Get.put(MapViewController());
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: FutureBuilder(
      future: mapViewController.main(),
      builder: (context, snapshot) {
        if (mapViewController.locationPermissionEnabled.value == false ||
            mapViewController.locationServiceEnabled.value == false) {
          if (mapViewController.locationPermissionEnabled.value == false) {
            return Center(
                child: BlurryContainer(
              child: Center(
                child: AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber[300],
                          size: windowWidth * 0.08,
                        ),
                      ),
                      Text(
                        "Location Permission",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.026),
                      )
                    ],
                  ),
                  content: Text(
                    "No se concedió permiso de ubicación",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: windowHeight * 0.02),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'Cerrar',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: windowHeight * 0.023,
                            color: Colors.amber[300]),
                      ),
                      onPressed: () {
                        // Cerrar el modal
                        Navigator.popAndPushNamed(context, '/home');
                      },
                    ),
                  ],
                ),
              ),
              blur: 2,
              width: windowWidth,
              height: windowHeight,
              elevation: 50,
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ));
          } else {
            return Center(
                child: BlurryContainer(
              child: Center(
                child: AlertDialog(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.amber[300],
                          size: windowWidth * 0.08,
                        ),
                      ),
                      Text(
                        "Location Disabled",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.026),
                      )
                    ],
                  ),
                  content: Text(
                    "El servicio de ubicación está desactivado",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: windowHeight * 0.02),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        'Cerrar',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: windowHeight * 0.023,
                            color: Colors.amber[300]),
                      ),
                      onPressed: () {
                        // Cerrar el modal
                        Navigator.popAndPushNamed(context, '/home');
                      },
                    ),
                  ],
                ),
              ),
              blur: 2,
              width: windowWidth,
              height: windowHeight,
              elevation: 50,
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ));
          }
        } else {
          return mapViewController.currentLocation == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: windowWidth,
                  height: windowHeight,
                  child: Padding(
                    padding: EdgeInsets.only(top: windowWidth * 0.1),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: windowWidth * 0.01),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: windowWidth * 0.03),
                                child: Ink(
                                  decoration: ShapeDecoration(
                                    color: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      Blurry.warning(
                                        //icon: null,
                                        //themeColor: Color.fromRGBO(6, 252, 163, 1),
                                        title: """Session finished""",
                                        description: "You route won't be saved",
                                        confirmButtonText: 'Confirm',
                                        onConfirmButtonPressed: () async {
                                          await mapViewController.close();
                                          await Get.delete<MapViewController>();
                                          Navigator.popAndPushNamed(
                                              context, '/home');
                                        },
                                        onCancelButtonPressed: () {},
                                        titleTextStyle: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: windowHeight * 0.03),
                                        descriptionTextStyle:
                                            GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: windowHeight * 0.023,
                                        ),
                                        buttonTextStyle: GoogleFonts.poppins(
                                            color: Colors.white),
                                      ).show(context);
                                    },
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: windowHeight * 0.01,
                                  left: windowWidth * 0.01),
                              child: Column(
                                children: [
                                  Text(
                                    homeController.activityType == "run"
                                        ? 'Running Route'
                                        : 'Biking Route',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: windowWidth * 0.06),
                                  ),
                                  Text(
                                    'Press the start button and stop whenever\nyou want to finish your session',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                        fontSize: windowWidth * 0.04,
                                        fontWeight: FontWeight.w300),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(windowHeight * 0.01),
                              child: SizedBox(
                                width: windowWidth * 0.95,
                                height: windowHeight * 0.6,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(windowWidth * 0.02),
                                    child: Obx(() => GoogleMap(
                                          onLongPress: (argument) {
                                            Navigator.popAndPushNamed(
                                                context, '/home');
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
                                              icon: mapViewController
                                                  .currentLocationIcon.value,
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
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: windowWidth * 0.08,
                              right: windowWidth * 0.08),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => Text(
                                            '${mapViewController.hours.value.toString().padLeft(2, '0')}:${mapViewController.minutes.value.toString().padLeft(2, '0')}:${mapViewController.seconds.value.toString().padLeft(2, '0')}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: windowWidth * 0.06),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Elapsed Time',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: windowWidth * 0.04,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => Text(
                                            '${mapViewController.showableDistance} KM',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: windowWidth * 0.06),
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Distance',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: windowWidth * 0.04,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (mapViewController.isRecording.value ==
                                          true) {
                                        Blurry.success(
                                          //icon: null,
                                          //themeColor: Color.fromRGBO(6, 252, 163, 1),
                                          title: """Session Finished""",
                                          description:
                                              'Your route has been saved. You can check your past routes in the history tab',
                                          confirmButtonText: 'Accept',
                                          onConfirmButtonPressed: () async {
                                            mapViewController
                                                .isRecording.value = false;
                                            await mapViewController
                                                .stopStopWatch();
                                            await mapViewController.close();
                                            await Get.delete<
                                                MapViewController>();
                                            Navigator.popAndPushNamed(
                                                context, '/home');
                                          },
                                          displayCancelButton: false,
                                          titleTextStyle: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: windowHeight * 0.03),
                                          descriptionTextStyle:
                                              GoogleFonts.poppins(
                                            fontWeight: FontWeight.w500,
                                            fontSize: windowHeight * 0.023,
                                          ),
                                          buttonTextStyle: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ).show(context);
                                      } else {
                                        await mapViewController.initStopWatch();
                                        mapViewController.isRecording.value =
                                            true;
                                      }
                                    },
                                    child: Container(
                                      width: windowWidth * 0.2,
                                      height: windowWidth * 0.2,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Color.fromRGBO(211, 244, 252, 1),
                                            Color.fromRGBO(135, 215, 235, 1),
                                            Color.fromRGBO(6, 252, 163, 1)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Obx(() => Icon(
                                            mapViewController
                                                        .isRecording.value ==
                                                    true
                                                ? Icons.stop_circle_outlined
                                                : IconlyLight.play,
                                            size: windowWidth * 0.2,
                                            color: Colors.white,
                                          )),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
        }
      },
    ));
  }
}
