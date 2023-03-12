import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/historyController.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static historyController myController = Get.put(historyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: myController.items.length,
          itemBuilder: (context, index) {
            return Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(5),
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.all(8),
                child: Text(
                  myController.items[index],
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
