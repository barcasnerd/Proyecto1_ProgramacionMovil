import 'package:flutter/material.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RouteScreen'),
      ),
      body: Center(
        child: Text("RouteScreen"),
      ),
    );
  }
}
