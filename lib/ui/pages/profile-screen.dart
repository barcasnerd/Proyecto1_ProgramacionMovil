import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static NavController controllerNav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
