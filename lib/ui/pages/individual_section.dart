import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import '../controllers/section_controller.dart';
import '../controllers/nav_controller.dart';

class IndividualSection extends StatelessWidget {
  const IndividualSection({super.key});
  static SectionController mySection = Get.put(SectionController());
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
        child: Column(children: [
          Text(mySection.sections[index],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: windowHeight * 0.04))),
          Container(
            //child: Image.asset('assets/maparecorrido.png'),
            height: windowHeight * 0.5,
            child: Image.network(
                "https://s1.ppllstatics.com/diariosur/www/multimedia/201805/25/media/cortadas/mapa-recorrido-magna-kzc-U502021277800ZuC-624x460@Diario%20Sur.jpg"),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: windowWidth * 0.08),
              child: Text("Starting location",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: windowHeight * 0.02))),
            ),
          ),
          Container(
            width: windowWidth * 0.9,
            child: TextFormField(
              style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                filled: true,
                border: InputBorder.none,

                hintText: '51.82749',
                //prefixIcon: Icon(IconlyLight.message)
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: windowWidth * 0.08),
              child: Text("Finishing location",
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: windowHeight * 0.02))),
            ),
          ),
          Container(
            width: windowWidth * 0.9,
            child: TextFormField(
              style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                filled: true,
                border: InputBorder.none,

                hintText: '64.23297',
                //prefixIcon: Icon(IconlyLight.message)
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: windowHeight * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () => {
                        mySection.eliminarSection(index),
                        Navigator.pop(context)
                      },
                      icon: Icon(
                        IconlyBold.password,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Delete',
                        style: GoogleFonts.poppins(
                            fontSize: windowHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(windowWidth * 0.5, windowHeight * 0.06),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(top: windowHeight * 0.05),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(157, 206, 255, 1),
                          Color.fromRGBO(6, 252, 163, 1)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () =>
                          {Navigator.of(context).popAndPushNamed('/home')},
                      icon: Icon(
                        IconlyBold.password,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Edit',
                        style: GoogleFonts.poppins(
                            fontSize: windowHeight * 0.02,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize:
                            Size(windowWidth * 0.5, windowHeight * 0.06),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ]),
      ),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
