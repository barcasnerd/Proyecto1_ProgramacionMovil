import 'package:get/get.dart';
import 'package:exercise_tracker/ui/pages/history-screen.dart';
import 'package:exercise_tracker/ui/pages/home_screen.dart';
import 'package:exercise_tracker/ui/pages/profile-screen.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;

  final List<Map<String, dynamic>> routes = [
    {'route': '/home', 'page': const HomeScreen()},
    {'route': '/history', 'page': const HistoryScreen()},
    {'route': '/profile', 'page': const ProfileScreen()},
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(routes[index]['route']);
  }
}
