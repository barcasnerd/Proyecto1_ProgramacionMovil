import 'package:exercise_tracker/ui/controllers/nav_controller.dart';
import 'package:exercise_tracker/ui/controllers/home_controller.dart';
import 'package:exercise_tracker/ui/widgets/CustomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static NavController controllerNav = Get.put(NavController());
  static HomeController controllerRoute = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hola Augusto!',
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.account_circle_rounded,
                        size: 120, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24.0),
            const Text(
              '¿Qué quieres\n hacer hoy?',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              height: 150.0,
              child: OutlinedButton.icon(
                onPressed: () {
                  controllerRoute.changePageRoute();
                },
                label: const Text(
                  'Trote',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(
                  Icons.directions_run,
                  color: Colors.black,
                  size: 130,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              height: 150.0,
              child: OutlinedButton.icon(
                onPressed: () {
                  controllerRoute.changePageRoute();
                },
                icon: const Icon(Icons.directions_bike,
                    color: Colors.black, size: 130),
                label: const Text(
                  'Bicicleta',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(controller: controllerNav),
    );
  }
}
