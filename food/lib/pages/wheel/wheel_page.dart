import 'package:flutter/material.dart';

class WheelPage extends StatelessWidget {
  const WheelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wheel of Luck 🎡")),
      body: const Center(
        child: Text(
          "Welcome to the Wheel Page!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
