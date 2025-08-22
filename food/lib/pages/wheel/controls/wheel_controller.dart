import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WheelController {
  final List<String> options;
  final List<String> imagePaths;
  final TickerProvider vsync;

  late final AnimationController wheelAnimationController;
  late final AnimationController imagePulseController;
  Animation<double>? wheelAnimation;

  double currentAngle = 0;
  int selectedIndex = -1;
  String selectedOption = "";
  bool showResult = false;

  List<ui.Image> images = [];

  WheelController({
    required this.options,
    required this.imagePaths,
    required this.vsync,
  }) {
    wheelAnimationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 4),
    );

    imagePulseController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  Future<void> loadImages() async {
    for (var path in imagePaths) {
      final data = await rootBundle.load(path);
      final bytes = data.buffer.asUint8List();
      final codec = await ui.instantiateImageCodec(bytes);
      final frame = await codec.getNextFrame();
      images.add(frame.image);
    }
  }

  void spinWheel(VoidCallback onComplete) {
    final random = Random();
    final spins = random.nextInt(5) + 5;
    final anglePerOption = 2 * pi / options.length;
    final randomOption = random.nextInt(options.length);
    final targetAngle = spins * 2 * pi + randomOption * anglePerOption;

    wheelAnimation =
        Tween<double>(
            begin: currentAngle,
            end: currentAngle + targetAngle,
          ).animate(
            CurvedAnimation(
              parent: wheelAnimationController,
              curve: Curves.easeOutCubic,
            ),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              currentAngle = wheelAnimation!.value % (2 * pi);
              double normalizedAngle = currentAngle % (2 * pi);
              double sectorAngle = 2 * pi / options.length;

              selectedIndex =
                  ((options.length -
                              ((normalizedAngle + pi / 2) / sectorAngle)
                                  .floor()) %
                          options.length)
                      .toInt();
              selectedOption = options[selectedIndex];
              currentAngle -= normalizedAngle % sectorAngle - sectorAngle / 2;

              showResult = true;
              onComplete();
            }
          });

    wheelAnimationController.reset();
    wheelAnimationController.forward();
    showResult = false;
  }

  void dispose() {
    wheelAnimationController.dispose();
    imagePulseController.dispose();
  }
}
