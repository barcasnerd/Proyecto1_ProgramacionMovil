import 'package:flutter/material.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draft Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Esta pagina será reemplazada por el login'),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/login")},
                child: const Text("Login")),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/home")},
                child: const Text("Home")),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/route")},
                child: const Text("Route")),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/map")},
                child: const Text("Map")),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/history")},
                child: const Text("History")),
            ElevatedButton(
                onPressed: () => {Navigator.of(context).pushNamed("/profile")},
                child: const Text("Profile")),
            ElevatedButton(
                onPressed: () =>
                    {Navigator.of(context).pushNamed("/individualTrack")},
                child: const Text("IndividualTrack")),
          ],
        ),
      ),
    );
  }
}
