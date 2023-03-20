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
                padding: EdgeInsets.only(top: windowHeight * 0.15),
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
                    onPressed: () {},
                    icon: Icon(
                      IconlyBold.login,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                          fontSize: windowHeight * 0.03,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(windowWidth * 0.8, windowHeight * 0.08),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: windowHeight * 0.03,
                  left: windowWidth * 0.09,
                  right: windowWidth * 0.09),
              child: Row(children: <Widget>[
                Expanded(child: Divider()),
                Text(
                  ' Or ',
                  style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                ),
                Expanded(child: Divider()),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(top: windowHeight * 0.03),
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don’t have an account yet?',
                        style:
                            GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      ),
                      TextButton(
                          onPressed: () => {},
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                                fontSize: windowHeight * 0.02),
                          ))
                    ]),
              ),
            ),
          ],
        ));
  }
}
