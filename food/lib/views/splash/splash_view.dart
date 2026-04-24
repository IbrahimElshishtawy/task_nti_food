import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';
import '../../theme/app_colors.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _SplashScene());
  }
}

class _SplashScene extends StatefulWidget {
  const _SplashScene();

  @override
  State<_SplashScene> createState() => _SplashSceneState();
}

class _SplashSceneState extends State<_SplashScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final pulse = Curves.easeInOut.transform(_controller.value);
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFFF2D8),
                Color(0xFFFFA15C),
                Color(0xFFFF6B35),
              ],
            ),
          ),
          child: Stack(
            children: <Widget>[
              _FloatingIcon(
                icon: Icons.local_pizza_rounded,
                top: 96,
                left: 34,
                phase: pulse,
                angle: -.22,
              ),
              _FloatingIcon(
                icon: Icons.icecream_rounded,
                top: 130,
                right: 42,
                phase: 1 - pulse,
                angle: .18,
              ),
              _FloatingIcon(
                icon: Icons.ramen_dining_rounded,
                bottom: 140,
                left: 46,
                phase: 1 - pulse,
                angle: .14,
              ),
              _FloatingIcon(
                icon: Icons.local_cafe_rounded,
                bottom: 110,
                right: 46,
                phase: pulse,
                angle: -.16,
              ),
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: .7, end: 1),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value.clamp(0, 1),
                      child: Transform.scale(scale: value, child: child),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Transform.translate(
                        offset: Offset(0, -10 * pulse),
                        child: Transform.rotate(
                          angle: math.sin(pulse * math.pi) * .025,
                          child: Container(
                            width: 132,
                            height: 132,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: .94),
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: AppColors.primaryDark.withValues(
                                    alpha: .28,
                                  ),
                                  blurRadius: 42,
                                  offset: const Offset(0, 24),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  width: 86,
                                  height: 86,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: <Color>[
                                        AppColors.primary,
                                        AppColors.butter,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                const Icon(
                                  Icons.restaurant_menu_rounded,
                                  color: Colors.white,
                                  size: 54,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 26),
                      TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: .82, end: 1),
                        duration: const Duration(milliseconds: 1100),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value.clamp(0, 1),
                            child: Transform.scale(scale: value, child: child),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Text(
                              'app_name'.tr,
                              style: Theme.of(context).textTheme.displaySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black.withValues(
                                          alpha: .14,
                                        ),
                                        blurRadius: 18,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'splash_tagline'.tr,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: .88),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 80,
                right: 80,
                bottom: MediaQuery.paddingOf(context).bottom + 56,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    color: Colors.white,
                    backgroundColor: Colors.white.withValues(alpha: .25),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FloatingIcon extends StatelessWidget {
  const _FloatingIcon({
    required this.icon,
    required this.phase,
    required this.angle,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final IconData icon;
  final double phase;
  final double angle;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Transform.translate(
        offset: Offset(0, (phase - .5) * 28),
        child: Transform.rotate(
          angle: angle + ((phase - .5) * .12),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: Colors.white.withValues(alpha: .28)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 24,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 34),
          ),
        ),
      ),
    );
  }
}
