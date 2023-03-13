import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/historyController.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static historyController myController = Get.put(historyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 2.0, // Ancho del borde
                        color: Colors.blue, // Color del borde
                      ),
                    ),
                    hintText:
                        'Tramo A', // Texto que aparece como sugerencia en el campo
                    prefixIcon: Icon(Icons
                        .search), // Icono que aparece a la izquierda del campo
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 0.45,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 2.0, // Ancho del borde
                        color: Colors.blue, // Color del borde
                      ),
                    ),
                    hintText:
                        'Tramo B', // Texto que aparece como sugerencia en el campo
                    prefixIcon: Icon(Icons
                        .search), // Icono que aparece a la izquierda del campo
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: myController.items.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: MediaQuery.of(context).size.width * 0.85,
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
                            "${myController.duration[index]} Minutos", // Muestra el texto del elemento
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  child: Text('Ver Mapa'),
                                  onPressed: () {
                                    // Aquí iría el código para abrir el mapa
                                  },
                                ),
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          //FloatingActionButton(onPressed: () => {myController.editarItem()})
        ],
      ),
    );
  }
}
