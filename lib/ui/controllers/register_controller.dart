import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterController extends GetxController {
  var firstName = "".obs;
  var lastName = "".obs;
  var email = "".obs;
  var password = "".obs;
  var gender = "".obs;
  var birth = "".obs;
  var weight = "".obs;
  var height = "".obs;
  var visiblePassword = true.obs;
  var invalidCredentials = false.obs;
  TextEditingController genderEditingController = TextEditingController();
  TextEditingController dateEditingController = TextEditingController();

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

  void validateCompleteProfile(BuildContext context) {
    if (weight.value.trim() == "") {
      height.value = "0.0";
    }
    if (weight.value.trim() == "") {
      weight.value = "0.0";
    }
    if (double.parse(height.value) <= 0 ||
        double.parse(weight.value) <= 0 ||
        gender.value == "" ||
        birth.value == "") {
      invalidCredentials.value = true;
    } else {
      print({
        firstName,
        lastName,
        email,
        password,
        gender,
        birth,
        weight,
        height
      });
      invalidCredentials.value = true;
      resetVariables();
      Navigator.popAndPushNamed(context, '/home');
    }
  }

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

  void changeGenderValue(String newValue) {
    gender.value = newValue;
    genderEditingController.text = newValue;
  }

  void changeDateValue(DateTime newDate) {
    birth.value = DateFormat('yyyy-MM-dd').format(newDate);
    dateEditingController.text = DateFormat('yyyy-MM-dd').format(newDate);
  }

  void resetVariables() {
    firstName.value = "";
    lastName.value = "";
    email.value = "";
    password.value = "";
    gender.value = "";
    birth.value = "";
    weight.value = "";
    height.value = "";
    visiblePassword.value = true;
    invalidCredentials.value = false;
    genderEditingController = TextEditingController();
    dateEditingController = TextEditingController();
  }
}
