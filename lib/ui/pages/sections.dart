import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/section_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class Sections extends StatelessWidget {
  const Sections({super.key});
  static SectionController mySection = Get.put(SectionController());
  static NavController controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
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
              child: Text('All Sections',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: windowHeight * 0.02))),
            ),
          ),
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: mySection.sections.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                mySection.changePage(index, 3);
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
                                      padding:
                                          EdgeInsets.fromLTRB(10, 25, 20, 25),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.earbuds,
                                            size: 40,
                                          )
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
                                                "${mySection.sections[index]} ",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
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
                ],
              ),
            ),
          ),
        ],
      )),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
