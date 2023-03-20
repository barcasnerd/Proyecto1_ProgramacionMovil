import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.1, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/main_logo.png'),
                    width: windowWidth * 0.5,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dunord Fit Tracker',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: windowHeight * 0.03))),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: windowWidth * 0.9,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
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
                          hintText: 'Email',
                          prefixIcon: Icon(IconlyLight.message)),
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
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      obscureText: true,
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
                          hintText: 'Password',
                          prefixIcon: Icon(IconlyLight.lock),
                          suffixIcon: Icon(IconlyLight.hide)),
                    ),
                  )),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: windowHeight * 0.2),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: null,
                    gradient: LinearGradient(colors: [
                      Color.fromRGBO(0, 195, 255, 1),
                      Color.fromRGBO(0, 255, 162, 1),
                    ]),
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  child: ElevatedButton.icon(
                    icon: Icon(IconlyBold.login),
                    onPressed: () => {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
                        minimumSize: MaterialStateProperty.all<Size>(
                            Size(windowWidth * 0.9, windowHeight * 0.09)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100.0),
                                    side: BorderSide.none))),
                    label: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: windowHeight * 0.03),
                    ),
                  ),
                ))
          ],
        ));
  }
}
