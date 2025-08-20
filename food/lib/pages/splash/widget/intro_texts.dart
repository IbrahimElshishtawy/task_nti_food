import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class IntroTexts extends StatelessWidget {
  const IntroTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FadeInDown(
          duration: const Duration(seconds: 2),
          delay: const Duration(milliseconds: 500),
          child: const Text(
            "Welcome to Our Restaurant",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.3,
              letterSpacing: 1,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        FadeInUp(
          duration: const Duration(seconds: 2),
          delay: const Duration(milliseconds: 800),
          child: const Text(
            "Discover our exquisite menu with delicious meals crafted using fresh ingredients. "
            "Enjoy fast delivery right to your doorstep and experience the taste, quality, and care "
            "that makes our restaurant a favorite for everyone!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.8,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
