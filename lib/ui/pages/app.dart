import 'package:exercise_tracker/ui/pages/draft_page.dart';
import 'package:exercise_tracker/ui/pages/history-screen.dart';
import 'package:exercise_tracker/ui/pages/home_screen.dart';
import 'package:exercise_tracker/ui/pages/individual-track-screen.dart';
import 'package:exercise_tracker/ui/pages/login.dart';
import 'package:exercise_tracker/ui/pages/map-screen.dart';
import 'package:exercise_tracker/ui/pages/profile-screen.dart';
import 'package:exercise_tracker/ui/pages/register_screen.dart';
import 'package:exercise_tracker/ui/pages/route-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercise Tracker',
      initialRoute: "/",
      routes: {
        "/": (context) => const DraftScreen(),
        "/login": (context) => const LoginScreen(),
        "/register":(context) => const RegisterScreen(),
        "/home": (context) => const HomeScreen(),
        "/route": (context) => const RouteScreen(),
        "/map": (context) => const MapScreen(),
        "/history": (context) => const HistoryScreen(),
        "/profile": (context) => const ProfileScreen(),
        "/individualTrack": (context) => const IndividualTrackScreen(),
      },
    );
  }
}
