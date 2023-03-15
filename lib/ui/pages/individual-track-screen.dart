import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    int index = args as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorrido'),
      ),
      body: Center(
          child: Column(
        children: [
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
        ],
      )),
    );
  }
}
