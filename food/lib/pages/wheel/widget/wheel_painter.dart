import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class WheelPainter extends CustomPainter {
  final List<String> options;
  final String selectedOption;
  final List<ui.Image> images;

  WheelPainter(this.options, {this.selectedOption = "", required this.images});

  @override
  void paint(Canvas canvas, Size size) {
    if (images.isNotEmpty && images.length != options.length) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final anglePerOption = 2 * pi / options.length;
    final contentRadius = radius * 0.55;

    for (int i = 0; i < options.length; i++) {
      final paint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.primaries[i % Colors.primaries.length].shade300,
            Colors.primaries[i % Colors.primaries.length].shade800,
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..style = PaintingStyle.fill;

      final startAngle = i * anglePerOption;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        anglePerOption,
        true,
        paint,
      );

      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(startAngle + anglePerOption / 2);

      final imageSize = radius * 0.15;
      if (images.isNotEmpty && images.length > i) {
        final imageRect = Rect.fromCenter(
          center: Offset(contentRadius, 0),
          width: imageSize,
          height: imageSize,
        );
        final clipPath = Path()..addOval(imageRect);
        canvas.save();
        canvas.clipPath(clipPath);
        paintImage(
          canvas: canvas,
          rect: imageRect,
          image: images[i],
          fit: BoxFit.cover,
        );
        canvas.restore();
      }

      final textPainter = TextPainter(
        text: TextSpan(
          text: options[i],
          style: TextStyle(
            color: options[i] == selectedOption ? Colors.yellow : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            shadows: const [
              Shadow(
                blurRadius: 2,
                color: Colors.black87,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.left,
      );
      textPainter.layout(maxWidth: radius * 0.3);
      textPainter.paint(
        canvas,
        Offset(contentRadius + imageSize / 2 + 4, -textPainter.height / 2),
      );

      canvas.restore();
    }

    final centerPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.redAccent, Colors.black87],
      ).createShader(Rect.fromCircle(center: center, radius: radius / 6))
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius / 6, centerPaint);

    final shadowPaint = Paint()
      ..color = Colors.black38
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(center, radius / 6, shadowPaint);
  }

  @override
  bool shouldRepaint(covariant WheelPainter oldDelegate) => true;
}
