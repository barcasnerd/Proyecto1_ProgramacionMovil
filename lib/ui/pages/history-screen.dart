import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
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
                                  onPressed: () =>
                                      {_deleteHistory(context, index)},
                                  child: Text(
                                    'Eliminar Recorrido',
                                    style: TextStyle(
                                        //fontSize: 20,
                                        ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors
                                        .red, // Cambia el color del botón a rojo
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  child: Text('Ver Mapa'),
                                  onPressed: () {
                                    myController.changePage();
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
                width: MediaQuery.of(context).size.width * 0.28,
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
                  ],
                ),
              ),
              Text("¿Esta seguro que desea eliminar este recorrido? "),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Confirmar'),
              onPressed: () =>
                  {myController.eliminarHistory(index), Navigator.pop(context)},
            ),
          ],
        );
      },
    );
  }
}
