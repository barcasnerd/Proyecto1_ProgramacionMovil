import 'package:get/get.dart';

class HomeController extends GetxController {
  Rx<String> activityType = "bike".obs;

  void changePageRoute() {
    Get.toNamed('/route');
  }
}
