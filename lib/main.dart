import 'package:exercise_tracker/ui/controllers/history_controller.dart';
import 'package:exercise_tracker/ui/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


void main() {
  // TODO: Put the injection of the controller
  
  Get.lazyPut<HistoryController>(() => HistoryController());
  
  // TODO: Add the main app widget page

  runApp(App());
}
