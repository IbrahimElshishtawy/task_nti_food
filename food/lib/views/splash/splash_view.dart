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
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    )..forward();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2300),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[
        _entranceController,
        _floatController,
      ]),
      builder: (context, child) {
        final entrance = Curves.easeOutCubic.transform(
          _entranceController.value,
        );
        final float = Curves.easeInOut.transform(_floatController.value);

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFFFF7733),
                Color(0xFFFFA85D),
                Color(0xFFFFE3B8),
                Color(0xFFFFF8EC),
              ],
              stops: <double>[0, .38, .72, 1],
            ),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(.05, -.08),
                      radius: .72,
                      colors: <Color>[
                        Colors.white.withValues(alpha: .58),
                        Colors.white.withValues(alpha: .18),
                        Colors.transparent,
                      ],
                      stops: const <double>[0, .38, 1],
                    ),
                  ),
                ),
              ),
              _IngredientParticle(
                icon: Icons.eco_rounded,
                top: 96,
                left: 36,
                phase: float,
                color: AppColors.leaf,
                size: 42,
              ),
              _IngredientParticle(
                icon: Icons.local_pizza_rounded,
                top: 142,
                right: 38,
                phase: 1 - float,
                color: AppColors.tomato,
                size: 50,
              ),
              _IngredientParticle(
                icon: Icons.grain_rounded,
                bottom: 176,
                left: 42,
                phase: 1 - float,
                color: AppColors.butter,
                size: 44,
              ),
              _IngredientParticle(
                icon: Icons.spa_rounded,
                bottom: 148,
                right: 46,
                phase: float,
                color: AppColors.mint,
                size: 40,
              ),
              Center(
                child: Opacity(
                  opacity: entrance,
                  child: Transform.scale(
                    scale: .86 + (.14 * entrance),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 292,
                          child: _FloatingFoodObject(float: float),
                        ),
                        const SizedBox(height: 8),
                        _BrandMark(entrance: entrance),
                        const SizedBox(height: 18),
                        Text(
                          'app_name'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                color: AppColors.charcoal,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0,
                                shadows: <Shadow>[
                                  Shadow(
                                    color: Colors.white.withValues(alpha: .64),
                                    blurRadius: 18,
                                    offset: const Offset(0, 7),
                                  ),
                                ],
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'splash_tagline'.tr,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .72),
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 88,
                right: 88,
                bottom: MediaQuery.paddingOf(context).bottom + 54,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    minHeight: 5,
                    color: AppColors.primary,
                    backgroundColor: Colors.white.withValues(alpha: .54),
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

class _FloatingFoodObject extends StatelessWidget {
  const _FloatingFoodObject({required this.float});

  final double float;

  @override
  Widget build(BuildContext context) {
    final hover = math.sin(float * math.pi);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          width: 250,
          height: 250,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.white.withValues(alpha: .70),
                  blurRadius: 78,
                  spreadRadius: 22,
                ),
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: .28),
                  blurRadius: 82,
                  spreadRadius: 10,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 34,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 152 - (hover * 18),
            height: 28 - (hover * 4),
            decoration: BoxDecoration(
              color: AppColors.charcoal.withValues(alpha: .18 - hover * .04),
              borderRadius: BorderRadius.circular(999),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.charcoal.withValues(alpha: .10),
                  blurRadius: 26,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -24 * hover),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .0018)
              ..rotateX(-.10 + (.05 * float))
              ..rotateY(-.16 + (.32 * float))
              ..rotateZ(math.sin(float * math.pi * 2) * .035),
            child: Container(
              width: 246,
              height: 182,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .26),
                borderRadius: BorderRadius.circular(46),
                border: Border.all(
                  color: Colors.white.withValues(alpha: .56),
                  width: 1.3,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: AppColors.primaryDark.withValues(alpha: .28),
                    blurRadius: 42,
                    offset: const Offset(0, 24),
                  ),
                  BoxShadow(
                    color: Colors.white.withValues(alpha: .38),
                    blurRadius: 28,
                    offset: const Offset(-10, -12),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/image/food50.png',
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.entrance});

  final double entrance;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .72 + (.28 * Curves.easeOutBack.transform(entrance)),
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .94),
          borderRadius: BorderRadius.circular(26),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primaryDark.withValues(alpha: .20),
              blurRadius: 34,
              offset: const Offset(0, 18),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Image.asset(
          'assets/icon/icon.png',
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

class _IngredientParticle extends StatelessWidget {
  const _IngredientParticle({
    required this.icon,
    required this.phase,
    required this.color,
    required this.size,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final IconData icon;
  final double phase;
  final Color color;
  final double size;
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
        offset: Offset(0, (phase - .5) * 34),
        child: Transform.rotate(
          angle: (phase - .5) * .42,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .28),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: .34)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.primaryDark.withValues(alpha: .12),
                  blurRadius: 22,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Icon(icon, color: color.withValues(alpha: .88), size: 22),
          ),
        ),
      ),
    );
  }
}
