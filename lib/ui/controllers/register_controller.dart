//aquí van cosas que todavia no tengo idea XD
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterController extends GetxController {
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var weight = 0.0.obs;
  var height = 0.0.obs;
  var visiblePassword = true.obs;
  var invalidCredentials = false.obs;

  void validateCreateAccount(BuildContext context) {
    invalidCredentials.value = !validateEmail(email.value) ||
        !validatePassword(password.value) ||
        !validateName(firstName.value) ||
        !validateName(lastName.value);
    print('📄${invalidCredentials.value}');
    if (invalidCredentials.value == false) {
      Navigator.popAndPushNamed(context, '/completeProfile');
    }
  }

  void validateCompleteProfile(BuildContext context) {}

  bool validateEmail(String email) {
    // Define a regular expression to validate the email format
    final RegExp regularExpression = RegExp(r'^[\w-.]+@([\w-]+.)+[\w-]{2,4}$');
    // Returns true if the email matches the expected format, otherwise false
    return regularExpression.hasMatch(email);
  }

  bool validatePassword(String password) {
    // Check if the password is empty
    if (password.isEmpty) {
      return false;
    }
    // Check if the password has spaces at the beginning or end
    if (password.trim() != password) {
      return false;
    }
    // If the password meets the validation criteria, return true
    return true;
  }

  bool validateName(String name) {
    // Check if the name is empty
    if (name.isEmpty) {
      return false;
    }
    // Check if the name has spaces at the beginning or end
    if (name.trim() != name) {
      return false;
    }
    // Check if the name contains only letters and spaces
    final RegExp nameRegex = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegex.hasMatch(name)) {
      return false;
    }
    // If the name meets the validation criteria, return true
    return true;
  }

  void togglePasswordVisibility() {
    visiblePassword.value = !visiblePassword.value;
  }

  void showGenderModal(context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;
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
                  style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                ),
                onTap: () {
                  gender.value = "Female";
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
                  style: GoogleFonts.poppins(fontSize: windowHeight * 0.02),
                ),
                onTap: () {
                  gender.value = "Male";
                  // Acción a realizar cuando se selecciona la opción 'Vídeo'
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
