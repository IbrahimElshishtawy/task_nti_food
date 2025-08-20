import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SplashTexts extends StatelessWidget {
  const SplashTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeIn(
          duration: const Duration(seconds: 2),
          delay: const Duration(milliseconds: 500),
          child: const Text(
            "Welcome my friend",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        SlideInUp(
          duration: const Duration(seconds: 2),
          delay: const Duration(milliseconds: 800),
          child: const Text(
            "Delicious food, fast delivery",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
