import 'package:get/get.dart';


class LoginController extends GetxController {

  void changePageHome() {
    Get.toNamed('/home');
  }
  void changePageRegister() {
    Get.toNamed('/register');
  }
}
