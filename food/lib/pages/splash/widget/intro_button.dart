import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class IntroButton extends StatelessWidget {
  const IntroButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      duration: const Duration(seconds: 2),
      delay: const Duration(milliseconds: 1200),
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 6,
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
