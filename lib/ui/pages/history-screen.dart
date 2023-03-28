import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';
import '../controllers/section_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static HistoryController myController = Get.put(HistoryController());
  static SectionController mySection = Get.put(SectionController());
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
            child: Obx(
              () => DropdownButton<String>(
                value: mySection.selectedItem.value,
                items: mySection.sections.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, windowWidth * 0.4, 0),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  log("Hice cambio ${newValue}");
                  _selectedValue = newValue ?? "";
                  mySection.setSelectedItem(_selectedValue);
                },
                style: TextStyle(color: Colors.black, fontSize: 16),
                underline: Container(),
              ),
            ),
          ),

          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 60, 0),
              child: GestureDetector(
                onTap: () {
                  mySection.changePage(0, 2);
                },
                child: Text('View all activities',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(fontSize: windowHeight * 0.018))),
              ),
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
                        myController.changePage(index, 1);
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
                                        "${myController.items[index]} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall,
                                      ),
                                      Text(
                                        "${myController.distance[index]} Km recorridos",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      Text(
                                        "${myController.duration[index]} de duracion",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
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
}
