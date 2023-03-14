import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final NavController controller;
  const CustomNavBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Historial',
            icon: Icon(Icons.history),
          ),
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
