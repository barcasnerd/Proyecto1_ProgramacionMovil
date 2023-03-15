import 'package:flutter/material.dart';

class IndividualTrackScreen extends StatelessWidget {
  const IndividualTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recorrido'),
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            width: 500,
            height: 500,
            color: Colors.blue,
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.amber,
                    child: Column(
                      children: [
                        Text(
                          "00:00:00",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Text("Tiempo"),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.cyanAccent,
                    child: Column(
                      children: [
                        Text(
                          "0 Km",
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
