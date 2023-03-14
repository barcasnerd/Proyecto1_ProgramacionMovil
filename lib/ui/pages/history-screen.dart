import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import '../controllers/nav_controller.dart';
import '../widgets/CustomNavBar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
  static NavController controllerNav = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: windowHeight * 0.04,
                    left: windowHeight * 0.001,
                    bottom: windowHeight * 0.005),
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
                padding: EdgeInsets.only(
                    top: windowHeight * 0.04,
                    left: windowHeight * 0.001,
                    bottom: windowHeight * 0.005),
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
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
