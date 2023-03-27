import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var visiblePassword = true.obs;
  var invalidCredentials = false.obs;

  void togglePasswordVisibility() {
    visiblePassword.value = !visiblePassword.value;
  }

  void validateEmailAndPassword(BuildContext context) {
    if (password.value == "q" && email.value == "q") {
      invalidCredentials.value = false;
      Navigator.popAndPushNamed(context, '/home');
    } else {
      invalidCredentials.value = true;
    }
  }
}
