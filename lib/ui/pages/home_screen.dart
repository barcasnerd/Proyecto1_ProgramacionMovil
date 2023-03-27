import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/controllers/home_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static NavController controllerNav = Get.put(NavController());
  static HomeController controllerRoute = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: windowHeight * 0.06),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: windowWidth * 0.01),
                      child: Text(
                        'Welcome Back,',
                        style: GoogleFonts.poppins(
                            fontSize: windowWidth * 0.05,
                            fontWeight: FontWeight.w300),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      'Stefani Wong',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: windowWidth * 0.08),
                      textAlign: TextAlign.start,
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(
                                left: windowWidth * 0.15,
                                top: 0,
                                right: windowWidth * 0.01),
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: windowHeight * 0.08,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            leading: Icon(
                                              Icons.logout,
                                              size: windowHeight * 0.04,
                                            ),
                                            title: Text(
                                              'Logout',
                                              style: GoogleFonts.poppins(
                                                  fontSize:
                                                      windowHeight * 0.02),
                                            ),
                                            onTap: () {
                                              // Acción a realizar cuando se selecciona la opción 'Música'
                                              Navigator.of(context)
                                                  .popAndPushNamed('/login');
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipOval(
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(38),
                                  child: Image(
                                      fit: BoxFit.cover,
                                      image: const AssetImage(
                                          'assets/images/profile_pic.png')),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: windowHeight * 0.04),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Are you ready to ride? ',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: windowWidth * 0.06),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: windowHeight * 0.007),
                    child: Text(
                      'Or maybe you want to run?\npick whatever you wanna do below ',
                      style: GoogleFonts.poppins(color: Colors.grey,
                          fontSize: windowWidth * 0.05,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              )
            ]),
          ),
          Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.03),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(211, 244, 252, 1),
                      Color.fromRGBO(135, 215, 235, 1),
                      Color.fromRGBO(6, 252, 163, 1)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton.icon(
                  onPressed: () =>
                      {Navigator.of(context).popAndPushNamed('/map')},
                  icon: Icon(null),
                  label: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Running',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: windowWidth * 0.07),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  'Enjoy a relaxing walk\nor a intense running\nsession, either wa\nwe will track it for you',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w300,
                                      fontSize: windowWidth * 0.04))
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: windowWidth * 0.05, top: 0, right: 0),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(40),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Color.fromRGBO(250, 250, 250, 0),
                                    BlendMode.saturation,
                                  ),
                                  child: Image(
                                    //fit: BoxFit.cover,
                                    image: const AssetImage(
                                        'assets/images/run_logo.png'),
                                    width: windowWidth * 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ],
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(windowWidth * 0.87, windowHeight * 0.2),
                    maximumSize: Size(windowWidth * 0.87, windowHeight * 0.2),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.02),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(211, 244, 252, 1),
                      Color.fromRGBO(135, 215, 235, 1),
                      Color.fromRGBO(6, 252, 163, 1)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton.icon(
                  onPressed: () =>
                      {Navigator.of(context).popAndPushNamed('/map')},
                  icon: Icon(null),
                  label: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Biking',
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: windowWidth * 0.07),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  'Push yourself to the\nlimit and track you\nbiking goals with ou\ngreat tracker',
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: windowWidth * 0.04))
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: windowWidth * 0.05, top: 0, right: 0),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(46),
                                child: ColorFiltered(
                                  colorFilter: const ColorFilter.mode(
                                    Color.fromRGBO(250, 250, 250, 0),
                                    BlendMode.saturation,
                                  ),
                                  child: Image(
                                    //fit: BoxFit.cover,
                                    image: const AssetImage(
                                        'assets/images/bike_logo.png'),
                                    width: windowWidth * 0.7,
                                  ),
                                ),
                              ),
                            ),
                          ])
                        ],
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(windowWidth * 0.87, windowHeight * 0.2), backgroundColor: Colors.transparent,
                    maximumSize: Size(windowWidth * 0.87, windowHeight * 0.2),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )),
        ],
      ),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
