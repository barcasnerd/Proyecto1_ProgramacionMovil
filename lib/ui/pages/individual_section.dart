import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import '../controllers/section_controller.dart';
import 'dart:ui';
import '../controllers/nav_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:geolocator/geolocator.dart';

class IndividualSection extends StatelessWidget {
  const IndividualSection({super.key});
  static SectionController mySection = Get.put(SectionController());
  static NavController controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    int index = args as int;
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
            return SizedBox(
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
                                Container(
                                  height: windowHeight * 0.05,
                                ),
                                Text(mySection.sections[index],
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: windowHeight * 0.04))),
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
                                    polylines: {
                                      Polyline(
                                        polylineId: PolylineId("route"),
                                        points: mySection.segments[index],
                                        color: Colors.red,
                                        width: 10,
                                      ),
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: windowHeight * 0.05),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: () => {
                                mySection.eliminarSection(index),
                                Navigator.pop(context)
                              },
                              icon: Icon(
                                IconlyBold.password,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Delete',
                                style: GoogleFonts.poppins(
                                    fontSize: windowHeight * 0.02,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    windowWidth * 0.5, windowHeight * 0.06),
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          )),
                      Spacer(),
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
