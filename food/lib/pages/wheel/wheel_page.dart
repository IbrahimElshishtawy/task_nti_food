import 'dart:math';
import 'package:flutter/material.dart';

class WheelPage extends StatefulWidget {
  const WheelPage({super.key});

  @override
  State<WheelPage> createState() => _WheelPageState();
}

class _WheelPageState extends State<WheelPage>
    with SingleTickerProviderStateMixin {
  final List<String> options = [
    "Pizza",
    "Burger",
    "Sushi",
    "Pasta",
    "Salad",
    "Dessert",
    "Drinks",
    "Steak",
  ];

  late AnimationController _controller;
  late Animation<double> _animation;

  double _currentAngle = 0;
  String _selectedOption = "";

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  void _spinWheel() {
    final random = Random();
    final spins = random.nextInt(5) + 5; // عدد الدورات العشوائية
    final anglePerOption = 2 * pi / options.length;
    final randomOption = random.nextInt(options.length);
    final targetAngle = spins * 2 * pi + randomOption * anglePerOption;

    _animation =
        Tween<double>(
            begin: _currentAngle,
            end: _currentAngle + targetAngle,
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                _currentAngle = _animation.value % (2 * pi);
                _selectedOption = options[randomOption];
              });
            }
          });

    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(title: const Text("Wheel of Luck 🎡")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Transform.rotate(
                angle: _animation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: List.generate(options.length, (index) {
                    final angle = 2 * pi * index / options.length;
                    return Transform.rotate(
                      angle: angle,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: size / 2,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors
                                .primaries[index % Colors.primaries.length]
                                .shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              options[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: _spinWheel,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "SPIN",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 20),
          if (_selectedOption.isNotEmpty)
            Text(
              "🎉 You got: $_selectedOption",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
