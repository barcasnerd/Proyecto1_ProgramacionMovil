import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class CustomNavBar extends StatelessWidget {
  final NavController controller;
  const CustomNavBar({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double windowHeight = MediaQuery.of(context).size.height;
    double windowWidth = MediaQuery.of(context).size.width;

    return Obx(
      () => BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(6, 252, 163, 1),
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              IconlyLight.home,
              size: windowHeight * 0.037,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              IconlyLight.activity,
              size: windowHeight * 0.037,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              IconlyLight.profile,
              size: windowHeight * 0.037,
            ),
          ),
        ],
      ),
    );
  }
}
