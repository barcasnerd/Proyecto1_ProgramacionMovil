import 'package:exercise_tracker/ui/controllers/history_controller.dart';
import 'package:exercise_tracker/ui/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.lazyPut<HistoryController>(() => HistoryController());
  runApp(App());
}
