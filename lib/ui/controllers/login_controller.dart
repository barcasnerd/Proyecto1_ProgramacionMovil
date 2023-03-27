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
    // TODO: validate password format

    if (email.value == "admin@admin.com" && password.value == "admin") {
      invalidCredentials.value = false;
      Navigator.popAndPushNamed(context, '/home');
    } else {
      invalidCredentials.value = true;
    }
  }
}
