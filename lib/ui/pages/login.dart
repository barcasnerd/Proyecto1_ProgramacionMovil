import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static NavController controller = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: const Center(
        child: Text("Pagina de login"),
      ),
      bottomNavigationBar: CustomNavBar(controller: controller),
    );
  }
}
