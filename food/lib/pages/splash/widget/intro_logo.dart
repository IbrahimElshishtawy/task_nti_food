import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class IntroLogo extends StatelessWidget {
  const IntroLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      duration: const Duration(seconds: 2),
      child: Container(
        height: 180,
        width: 180,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset("assets/image/imageintro.png", fit: BoxFit.cover),
        ),
      ),
    );
  }
}
