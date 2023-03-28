import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../controllers/section_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
  static SectionController mySection = Get.put(SectionController());
  static NavController controllerNav = Get.put(NavController());
  static CameraPosition _initialPosition =
      CameraPosition(target: LatLng(26.8206, 30.8025), zoom: 10.0);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    int index = args as int;
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
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Text('Error'),
                ));
          } else if (snapshot.hasData) {
            BitmapDescriptor currentLocationIcon =
                BitmapDescriptor.defaultMarker;
            BitmapDescriptor.fromAssetImage(
                    ImageConfiguration.empty, 'assets/profile_pic.png')
                .then(
              (icon) {
                currentLocationIcon = icon;
              },
            );
            return Container(
                width: windowWidth,
                height: windowHeight,
                child: Padding(
                  padding: EdgeInsets.only(top: windowWidth * 0.02),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: windowWidth * 0.01),
                        child: Row(
                          children: [],
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
                                  myController.items[index],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32),
                                ),
                                Text(
                                  'You can create sections on past routes \nby clicking the plus button',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
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
                              width: windowWidth * 0.9,
                              height: windowHeight * 0.5,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(windowWidth * 0.02),
                                  child: GoogleMap(
                                    markers: Set<Marker>.of([
                                      Marker(
                                        icon: currentLocationIcon,
                                        markerId: MarkerId('initial_marker'),
                                        position: LatLng(
                                            snapshot.data?.latitude ??
                                                10.963889,
                                            snapshot.data?.longitude ??
                                                -74.796387),
                                      )
                                    ]),
                                    minMaxZoomPreference:
                                        MinMaxZoomPreference(15, 18),
                                    mapType: MapType.normal,
                                    onMapCreated: (controller) {
                                      controller.setMapStyle(
                                          ' [{"featureType":"poi","stylers":[{"visibility":"off"}]}]');
                                    },
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            snapshot.data?.latitude ??
                                                10.963889,
                                            snapshot.data?.longitude ??
                                                -74.796387),
                                        zoom: 15.0),
                                  ),
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
                                    Text(
                                      myController.duration[index],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: windowWidth * 0.06),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Duration',
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
                                    Text(
                                      "${myController.distance[index]} Km",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: windowWidth * 0.06),
                                    )
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
                                  onTap: () {
                                  mySection.changePage(index, 4);
                                  print("Indice: ${index}");
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
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      IconlyLight.plus,
                                      size: windowWidth * 0.15,
                                      color: Colors.white,
                                    ),
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
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }

  void _deleteHistory(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: MediaQuery.of(context).size.width * 0.38,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${myController.items[index]} ", // Muestra la fecha y hora del elemento
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "${myController.distance[index]} Km recorridos", // Muestra el texto del elemento
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      "${myController.duration[index]} de duracion", // Muestra el texto del elemento
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Text("Are you sure that you want to delete the route? "),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(157, 206, 255, 1),
                    Color.fromRGBO(6, 252, 163, 1)
                  ],
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: ElevatedButton(
                child: Text('Accept'),
                onPressed: () => {
                  myController.eliminarHistory(index),
                },
              ),
            ),
          ],
        );
      },
    );
  }

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
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    return position;
  }
}
