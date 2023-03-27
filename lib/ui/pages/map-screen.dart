import 'package:blurry/blurry.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';

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
                  "Location service is disabled or blocked. Please, enable locationd and allow location permissions to continue",
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
        } else if (snapshot.hasData) {
          BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
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
                padding: EdgeInsets.only(top: windowWidth * 0.1),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: windowWidth * 0.01),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: windowWidth * 0.03),
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
                                    onConfirmButtonPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, '/home');
                                    },
                                    onCancelButtonPressed: () {},
                                    titleTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: windowHeight * 0.03),
                                    descriptionTextStyle: GoogleFonts.poppins(
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
                                'Running Route',
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
                                child: GoogleMap(
                                  markers: Set<Marker>.of([
                                    Marker(
                                      icon: currentLocationIcon,
                                      markerId: MarkerId('initial_marker'),
                                      position: LatLng(
                                          snapshot.data?.latitude ?? 10.963889,
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
                                          snapshot.data?.latitude ?? 10.963889,
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
                          left: windowWidth * 0.08, right: windowWidth * 0.08),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '00:00:00',
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
                                  Text(
                                    '0 KM',
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
                                  Blurry.success(
                                    //icon: null,
                                    //themeColor: Color.fromRGBO(6, 252, 163, 1),
                                    title: """Session Finished""",
                                    description:
                                        'Your route has been saved. You can check your past routes in the history tab',
                                    confirmButtonText: 'Accept',
                                    onConfirmButtonPressed: () {
                                      Navigator.popAndPushNamed(
                                          context, '/home');
                                    },
                                    displayCancelButton: false,
                                    titleTextStyle: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: windowHeight * 0.03),
                                    descriptionTextStyle: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: windowHeight * 0.023,
                                    ),
                                    buttonTextStyle: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ).show(context);
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
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Icon(
                                    IconlyLight.play,
                                    size: windowWidth * 0.2,
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
    ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }
}
