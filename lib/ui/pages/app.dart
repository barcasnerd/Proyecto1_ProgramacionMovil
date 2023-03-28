import 'package:exercise_tracker/ui/pages/complete_profile_screen.dart';
import 'package:exercise_tracker/ui/pages/draft_page.dart';
import 'package:exercise_tracker/ui/pages/history-screen.dart';
import 'package:exercise_tracker/ui/pages/home_screen.dart';
import 'package:exercise_tracker/ui/pages/individual-track-screen.dart';
import 'package:exercise_tracker/ui/pages/login.dart';
import 'package:exercise_tracker/ui/pages/map-screen.dart';
import 'package:exercise_tracker/ui/pages/profile-screen.dart';
import 'package:exercise_tracker/ui/pages/register_screen.dart';
import 'package:exercise_tracker/ui/pages/route-screen.dart';
import 'package:exercise_tracker/ui/pages/section_creator.dart';
import 'package:exercise_tracker/ui/pages/sections.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'individual_section.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercise Tracker',
      initialRoute: "/login",
      routes: {
        // "/": (context) => const DraftScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/completeProfile": (context) => const CompleteProfileScreen(),
        "/home": (context) => const HomeScreen(),
        "/route": (context) => RouteScreen(),
        "/map": (context) => MapScreen(),
        "/history": (context) => const HistoryScreen(),
        "/profile": (context) => const ProfileScreen(),
        "/individualTrack": (context) => const IndividualTrackScreen(),
        "/sections": (context) => const Sections(),
        "/individualSection": (context) => const IndividualSection(),
        "/sectionCreator": (context) => const SectionCreator(),
      },
       onUnknownRoute: (settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  },
);
  }
}
