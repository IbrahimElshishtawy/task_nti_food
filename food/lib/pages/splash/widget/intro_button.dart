import 'package:flutter/material.dart';
import 'dart:async';

class IntroButton extends StatefulWidget {
  const IntroButton({super.key});

  @override
  State<IntroButton> createState() => _IntroButtonState();
}

class _IntroButtonState extends State<IntroButton> {
  Color bgColor = Colors.white;
  late Timer _timer;

  final List<Color> colors = [Colors.white, Colors.yellowAccent];

  int index = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(milliseconds: 600), (timer) {
      setState(() {
        index = (index + 1) % colors.length;
        bgColor = colors[index];
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => Navigator.pushReplacementNamed(context, "/home"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // مهم: نخلي الخلفية شفافة
          shadowColor: Colors.transparent, // مهم: نلغي ظل ElevatedButton
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          "Get Started",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
