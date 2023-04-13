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

class SectionCreator extends StatelessWidget {
  const SectionCreator({super.key});
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
      body: Center(
        child: ListView(children: [
          FutureBuilder(
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
                                    Text(
                                      "Section Creator",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 32),
                                    ),
                                    Text(
                                      'Select four points on the map to \ncreate a new section',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          color: Colors.grey,
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
                                      padding:
                                          EdgeInsets.all(windowWidth * 0.02),
                                      child: Obx(() => GoogleMap(
                                            minMaxZoomPreference:
                                                MinMaxZoomPreference(15, 18),
                                            mapType: MapType.normal,
                                            onMapCreated: (controller) {
                                              controller.setMapStyle(
                                                  ' [{"featureType":"poi","stylers":[{"visibility":"off"}]}]');
                                            },
                                            zoomControlsEnabled: false,
                                            initialCameraPosition:
                                                CameraPosition(
                                                    target: LatLng(
                                                        snapshot.data
                                                                ?.latitude ??
                                                            10.963889,
                                                        snapshot.data
                                                                ?.longitude ??
                                                            -74.796387),
                                                    zoom: 15.0),
                                            // Agregar onTap y una función que maneje el evento
                                            onTap: (LatLng latLng) {
                                              mySection.addCoordinate(latLng);
                                              print(mySection.coordinatesList);
                                            },
                                            polylines: {
                                              Polyline(
                                                polylineId: PolylineId("route"),
                                                points: myController
                                                    .historial[index],
                                                color: Colors.red,
                                                width: 10,
                                              ),
                                              Polyline(
                                                polylineId:
                                                    PolylineId("section"),
                                                points: mySection
                                                    .coordinatesList.value,
                                                color: Color(0xff09fba5),
                                                width: 6,
                                              ),
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: windowWidth * 0.08,
                                right: windowWidth * 0.08,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: SizedBox(
                                    width: windowWidth * 0.9,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) =>
                                          mySection.nameSection.value = value,
                                      style: GoogleFonts.poppins(
                                          fontSize: windowHeight * 0.02),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0))),
                                          filled: true,
                                          border: InputBorder.none,
                                          hintText: 'Section name',
                                          prefixIcon: Icon(IconlyLight.paper)),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromRGBO(157, 206, 255, 1),
                                  Color.fromRGBO(6, 252, 163, 1)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: ElevatedButton(
                              onPressed: () =>
                                  //darle funcionalidad cuando tengamos los controladores
                                  {
                                mySection.saveSegment(mySection.coordinatesList,
                                    mySection.nameSection),
                                Navigator.of(context)
                                    .popAndPushNamed('/sections')
                              },
                              child: Text(
                                'Create section',
                                style: GoogleFonts.poppins(
                                    fontSize: windowHeight * 0.02,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    windowWidth * 0.5, windowHeight * 0.06),
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
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
        ]),
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
