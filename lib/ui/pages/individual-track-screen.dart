import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
  static NavController controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    int index = args as int;
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Text(myController.items[index],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: windowHeight * 0.04))),
          Container(
            //child: Image.asset('assets/maparecorrido.png'),
            child: Image.network(
                "https://s1.ppllstatics.com/diariosur/www/multimedia/201805/25/media/cortadas/mapa-recorrido-magna-kzc-U502021277800ZuC-624x460@Diario%20Sur.jpg"),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "${myController.duration[index]}",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text("Tiempo"),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "${myController.distance[index]} Km",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text("Distancia"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () => {_deleteHistory(context, index)},
              child: Text(
                'Delete',
                style: TextStyle(
                    //fontSize: 20,
                    ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Cambia el color del botón a rojo
              ),
            ),
          ]),
        ],
      )),
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
}
