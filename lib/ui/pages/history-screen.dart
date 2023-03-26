import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
  static NavController controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    String _selectedValue;
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Text('History',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: windowHeight * 0.04))),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Latest Activity',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: windowHeight * 0.02))),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromARGB(250, 247, 248, 248),
            ),
            width: windowWidth * 0.8,
            child: DropdownButton<String>(
              value: myController.selectedItem.value,
              items: myController.myList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                log("Hice cambio ${newValue}");
                _selectedValue = newValue ?? "";
                myController.setSelectedItem(_selectedValue);
              },
            ),
          ),

          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
              child: Text('View all activities',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(fontSize: windowHeight * 0.018))),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: myController.items.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        myController.changePage(index);
                        print('El container fue presionado');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(30, 158, 158, 158),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(10, 25, 20, 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  myController.type[index]
                                      ? Icon(
                                          Icons.directions_bike_rounded,
                                          size: 40,
                                        )
                                      : Icon(
                                          Icons.accessibility_rounded,
                                          size: 40,
                                        ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${myController.items[index]} ", // Muestra la fecha y hora del elemento
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        "${myController.distance[index]} Km recorridos", // Muestra el texto del elemento
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        "${myController.duration[index]} de duracion", // Muestra el texto del elemento
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () =>
                                            {_deleteHistory(context, index)},
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              //fontSize: 20,
                                              ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors
                                              .red, // Cambia el color del botón a rojo
                                        ),
                                      ),
                                    ]),
                              ],
                            ),
                          ],
                        ),
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
                  Navigator.pop(context)
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
