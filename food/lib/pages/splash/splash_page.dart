import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food/pages/splash/widget/splash_logo.dart';
import 'package:food/pages/splash/widget/splash_texts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final List<List<Color>> gradientColors = [
    [Colors.red, Colors.orange],
    [Color.fromARGB(255, 176, 151, 39), Color.fromARGB(255, 233, 148, 30)],
    [Color.fromARGB(255, 243, 184, 33), Color.fromARGB(255, 150, 127, 0)],
    [Color.fromARGB(255, 175, 158, 76), Colors.yellow],
  ];
  int index = 0;
  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        index = (index + 1) % gradientColors.length;
      });
    });
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, "/intro");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors[index],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [SplashLogo(), SizedBox(height: 20), SplashTexts()],
          ),
        ),
      ),
    );
  }
}
