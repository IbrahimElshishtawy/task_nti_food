// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:food/pages/wheel/widget/wheel_painter.dart';
import 'controls/wheel_controller.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage> with TickerProviderStateMixin {
  late WheelController wheelController;

  final List<String> options = [
    "First 10 Reservations",
    "Try Again",
    "Pizza Discount",
    "Drinks Offer",
    "Large Tables Discount",
    "good Luck",
  ];

  final List<String> imagePaths = [
    "assets/image/foodpeple.png",
    "assets/image/agin.png",
    "assets/image/food1.jpeg",
    "assets/image/food2.jpeg",
    "assets/image/foodpeple.png",
    "assets/image/goodluck.jpeg",
  ];

  @override
  void initState() {
    super.initState();
    wheelController = WheelController(
      options: options,
      imagePaths: imagePaths,
      vsync: this,
    );
    wheelController.loadImages().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    wheelController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    wheelController.spinWheel(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final wheelSize = MediaQuery.of(context).size.width * 0.95;

    if (wheelController.images.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            "Wheel of Luck",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.redAccent,
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(color: Colors.redAccent),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white, // خلفية الصفحة بيضاء بالكامل
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar أبيض
        elevation: 0,
        title: const Text(
          "Wheel of Luck",
          style: TextStyle(
            color: Colors.redAccent, // النص فقط لونه أحمر
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.redAccent, // أيقونة الرجوع حمراء فقط
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: wheelSize,
              height: wheelSize,
              child: AnimatedBuilder(
                animation: wheelController.wheelAnimationController,
                builder: (_, __) {
                  double angle =
                      wheelController.wheelAnimation?.value ??
                      wheelController.currentAngle;
                  return Transform.rotate(
                    angle: angle,
                    child: CustomPaint(
                      painter: WheelPainter(
                        options,
                        selectedOption: wheelController.selectedOption,
                        images: wheelController.images,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: _spinWheel,
              child: AnimatedScale(
                scale: wheelController.wheelAnimationController.isAnimating
                    ? 0.95
                    : 1.0,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.redAccent, width: 2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    "SPIN",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent, // النص أحمر فقط
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (wheelController.showResult &&
                wheelController.selectedIndex >= 0 &&
                wheelController.images.isNotEmpty)
              Column(
                children: [
                  Text(
                    "${wheelController.selectedOption}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: wheelSize * 0.25,
                    height: wheelSize * 0.25,
                    child: RawImage(
                      image:
                          wheelController.images[wheelController.selectedIndex],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
