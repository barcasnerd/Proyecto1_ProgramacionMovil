import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var visiblePassword = true.obs;
  var invalidCredentials = false.obs;
  var isLogged = false.obs;

  void togglePasswordVisibility() {
    visiblePassword.value = !visiblePassword.value;
  }

  void validateEmailAndPassword(BuildContext context) {
    // TODO: validate email format
    invalidCredentials.value = !validateEmail(email.value);
    // TODO: validate password format
    invalidCredentials.value = !validatePassword(password.value);

    // TODO: remove this lines for actual data
    if (email.value == "admin@admin.com" && password.value == "admin") {
      invalidCredentials.value = false;
      Navigator.popAndPushNamed(context, '/home');
    } else {
      invalidCredentials.value = true;
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
}
