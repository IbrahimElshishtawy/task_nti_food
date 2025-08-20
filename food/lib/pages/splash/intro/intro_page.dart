import 'package:flutter/material.dart';
import 'package:food/pages/splash/widget/intro_background.dart';
import 'package:food/pages/splash/widget/intro_button.dart';
import 'package:food/pages/splash/widget/intro_logo.dart';
import 'package:food/pages/splash/widget/intro_texts.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const IntroBackground(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  IntroLogo(),
                  SizedBox(height: 30),
                  IntroTexts(),
                  SizedBox(height: 50),
                  IntroButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
