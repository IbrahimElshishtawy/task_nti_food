import 'package:flutter/material.dart';

class IntroBackground extends StatelessWidget {
  const IntroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.redAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

        Positioned(
          top: 100,
          left: 50,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          right: 60,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
