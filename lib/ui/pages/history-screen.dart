import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/HistoryController.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryScreen'),
      ),
      body: Center(
        child: Text("HistoryScreen"),
      ),
    );
  }
}
