import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      duration: const Duration(seconds: 2),
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/image/introApp.jpeg", // PNG شفافة
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
