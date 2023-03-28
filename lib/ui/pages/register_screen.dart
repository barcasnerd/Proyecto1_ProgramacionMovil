import 'package:blurry/blurry.dart';
import 'package:exercise_tracker/ui/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: windowHeight * 0.1),
                  child: Text('Create an Account',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: windowHeight * 0.03))),
                )
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
                      onChanged: (value) {
                        registerController.firstName.value = value;
                      },
                      keyboardType: TextInputType.name,
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
                          hintText: 'First Name',
                          prefixIcon: Icon(IconlyLight.profile)),
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
                      onChanged: (value) {
                        registerController.lastName.value = value;
                      },
                      keyboardType: TextInputType.name,
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
                          hintText: 'Last Name',
                          prefixIcon: Icon(IconlyLight.profile)),
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
                      onChanged: (value) {
                        registerController.email.value = value;
                      },
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
                      onChanged: (value) {
                        registerController.password.value = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      obscureText: registerController.visiblePassword.value,
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              registerController.togglePasswordVisibility();
                            },
                            child: Icon(IconlyLight.hide),
                          )),
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
                    onPressed: () {
                      registerController.validateCreateAccount(context);
                      if (registerController.invalidCredentials.value == true) {
                        Blurry.error(
                          title: """Invalid fields""",
                          description:
                              'Invalid fields, please check and try again',
                          confirmButtonText: 'Accept',
                          onConfirmButtonPressed: () {
                            Navigator.pop(context);
                          },
                          displayCancelButton: false,
                          titleTextStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: windowHeight * 0.03),
                          descriptionTextStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: windowHeight * 0.023,
                          ),
                          buttonTextStyle:
                              GoogleFonts.poppins(color: Colors.white),
                        ).show(context);
                      }
                    },
                    icon: Icon(null),
                    label: Text(
                      'Register',
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
                        'Already have an account?',
                        style:
                            GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                      ),
                      TextButton(
                          onPressed: () =>
                              {Navigator.of(context).popAndPushNamed('/login')},
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                                fontSize: windowHeight * 0.02,
                                fontWeight: FontWeight.bold),
                          ))
                    ]),
              ),
            ),
          ],
        )));
  }
}
