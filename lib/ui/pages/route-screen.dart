import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:indexed/indexed.dart';

class RouteScreen extends StatelessWidget {
  RouteScreen({super.key});

  CameraPosition _initialPosition = CameraPosition(
      target: LatLng(10.980768198438865, -74.80697509093083), zoom: 12.0);

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text('RouteScreen'),
        ),
        body: Indexer(
          children: [
            Indexed(
                index: 1000,
                child: Padding(
                  padding: EdgeInsets.all(windowWidth * 0.04),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(windowWidth * 0.01),
                            child: FloatingActionButton(
                              onPressed: () => {},
                              child: const Icon(Icons.play_arrow),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(windowWidth * 0.01),
                            child: FloatingActionButton(
                              onPressed: () => {},
                              child: const Icon(Icons.pause),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(windowWidth * 0.01),
                            child: FloatingActionButton(
                              onPressed: () => {},
                              child: const Icon(Icons.stop),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
            /////[]/////
            Indexed(
                child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: windowHeight * 0.01,
                          left: windowHeight * 0.001,
                          bottom: windowHeight * 0.005),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => {Navigator.pop(context)},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: windowHeight * 0.01,
                          left: windowHeight * 0.002,
                          bottom: windowHeight * 0.005),
                      child: Text(
                        "Ruta en Bicicleta",
                        style: TextStyle(
                            fontSize: windowHeight * 0.05,
                            fontWeight: FontWeight.bold),
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
                          width:
                              windowWidth * 0.95, // or use fixed size like 200
                          height: windowHeight * 0.68,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                              child: GoogleMap(
                                initialCameraPosition: _initialPosition,
                                zoomControlsEnabled: false,
                              ),
                            ),
                          )),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(windowHeight * 0.01),
                              child: Text(
                                '00:00:00',
                                style: TextStyle(
                                    fontSize: windowHeight * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(windowHeight * 0.01),
                              child: const Text("Tiempo"),
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(windowHeight * 0.01),
                              child: Text(
                                '0 Km',
                                style: TextStyle(
                                    fontSize: windowHeight * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(windowHeight * 0.01),
                              child: const Text("Distancia"),
                            )
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: windowHeight * 0.07,
                        )
                      ],
                    )
                  ],
                )
              ],
            )),
          ],
        ));
  }
}
