import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.01, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image:
                        const AssetImage('assets/images/complete_profile.png'),
                    width: windowWidth * 0.8,
                    height: windowHeight * 0.4,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Let’s complete your profile',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.03))),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('It will help us to know more about you!',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        textStyle: TextStyle(fontSize: windowHeight * 0.02))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: windowWidth * 0.9,
                    child: TextFormField(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: windowHeight * 0.15,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.female,
                                      size: windowHeight * 0.04,
                                    ),
                                    title: Text(
                                      'Female',
                                      style: GoogleFonts.poppins(
                                          fontSize: windowHeight * 0.02),
                                    ),
                                    onTap: () {
                                      // Acción a realizar cuando se selecciona la opción 'Música'
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      Icons.male,
                                      size: windowHeight * 0.04,
                                    ),
                                    title: Text(
                                      'Male',
                                      style: GoogleFonts.poppins(
                                          fontSize: windowHeight * 0.02),
                                    ),
                                    onTap: () {
                                      // Acción a realizar cuando se selecciona la opción 'Vídeo'
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      enableInteractiveSelection: false,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                        filled: true,
                        border: InputBorder.none,
                        hintText: 'Choose Gender',
                        prefixIcon: Icon(IconlyLight.user),
                        suffixIcon: Icon(IconlyLight.arrow_down_2),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: windowWidth * 0.9,
                    child: TextFormField(
                      onTap: () {
                        showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                      },
                      readOnly: true,
                      keyboardType: TextInputType.datetime,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          filled: true,
                          hintText: 'Date of Birth',
                          prefixIcon: Icon(IconlyLight.calendar)),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: windowHeight * 0.02, left: windowHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: windowWidth * 0.7,
                    child: TextFormField(
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          filled: true,
                          hintText: 'Your Weight',
                          prefixIcon: Icon(Icons.balance_outlined)),
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.only(
                      left: windowHeight * 0.022,
                      right: windowHeight * 0.022,
                    ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'KG',
                              style: GoogleFonts.poppins(
                                  fontSize: windowHeight * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(windowWidth * 0.1, windowHeight * 0.01),
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: windowHeight * 0.02, left: windowHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: windowWidth * 0.7,
                    child: TextFormField(
                      onTap: () {},
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          filled: true,
                          hintText: 'Your Height',
                          prefixIcon: Icon(IconlyLight.swap)),
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.only(
                      left: windowHeight * 0.022,
                      right: windowHeight * 0.022,
                    ),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: ElevatedButton(
                            onPressed: () => {},
                            child: Text(
                              'CM',
                              style: GoogleFonts.poppins(
                                  fontSize: windowHeight * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  Size(windowWidth * 0.1, windowHeight * 0.01),
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: windowHeight * 0.02),
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
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            {Navigator.of(context).popAndPushNamed('/home')},
                        icon: Icon(
                          IconlyLight.arrow_right_2,
                          color: Colors.white,
                          textDirection: TextDirection.ltr,
                        ),
                        label: Text(
                          'Next',
                          style: GoogleFonts.poppins(
                              fontSize: windowHeight * 0.03,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(windowWidth * 0.8, windowHeight * 0.08),
                          primary: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ),
                    ))),
          ],
        ));
  }
}