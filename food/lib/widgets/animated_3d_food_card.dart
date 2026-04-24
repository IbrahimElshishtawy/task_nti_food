import 'dart:async';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';

class Animated3DFoodCard extends StatefulWidget {
  const Animated3DFoodCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onCart,
    this.index = 0,
  });

  final FoodModel food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onCart;
  final int index;

  @override
  State<Animated3DFoodCard> createState() => _Animated3DFoodCardState();
}

class _Animated3DFoodCardState extends State<Animated3DFoodCard> {
  bool _visible = false;
  bool _pressed = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(milliseconds: 55 * math.min(widget.index, 10)), () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  void didUpdateWidget(covariant Animated3DFoodCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.food.id != widget.food.id) {
      _visible = false;
      _timer?.cancel();
      _timer = Timer(
        Duration(milliseconds: 55 * math.min(widget.index, 10)),
        () {
          if (mounted) setState(() => _visible = true);
        },
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 420),
      curve: Curves.easeOutCubic,
      child: AnimatedSlide(
        offset: _visible ? Offset.zero : const Offset(0, .16),
        duration: const Duration(milliseconds: 420),
        curve: Curves.easeOutCubic,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          onTap: () => Get.toNamed(AppRoutes.details, arguments: widget.food),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0015)
              ..rotateX(_pressed ? .018 : -.035)
              ..rotateY(_pressed ? -.018 : .04)
              ..scale(_pressed ? .985 : 1.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned.fill(
                  top: 54,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primaryDark.withValues(
                            alpha: _pressed ? .10 : .18,
                          ),
                          blurRadius: _pressed ? 18 : 34,
                          offset: Offset(0, _pressed ? 10 : 22),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              colorScheme.surface,
                              AppColors.butter.withValues(alpha: .13),
                              AppColors.primary.withValues(alpha: .08),
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14, 72, 14, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      widget.food.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            height: 1.05,
                                          ),
                                    ),
                                  ),
                                  if (widget.food.isPopular)
                                    const Icon(
                                      Icons.local_fire_department_rounded,
                                      color: AppColors.tomato,
                                      size: 20,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.star_rounded,
                                    color: AppColors.butter,
                                    size: 17,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    widget.food.rating.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    Icons.schedule_rounded,
                                    color: colorScheme.onSurfaceVariant,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    child: Text(
                                      widget.food.preparationTime,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: colorScheme.onSurfaceVariant,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if (widget.food.oldPrice >
                                            widget.food.price)
                                          Text(
                                            CurrencyFormatter.format(
                                              widget.food.oldPrice,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                              fontSize: 11,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        Text(
                                          CurrencyFormatter.format(
                                            widget.food.price,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                color: colorScheme.primary,
                                                fontWeight: FontWeight.w900,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  _CircleButton(
                                    icon: Icons.add_rounded,
                                    color: Colors.white,
                                    background: colorScheme.primary,
                                    onTap: widget.onCart,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  left: 14,
                  right: 14,
                  height: 122,
                  child: Hero(
                    tag: 'food-${widget.food.id}',
                    child: Transform.rotate(
                      angle: _visible ? -math.pi / 64 : -math.pi / 8,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: 2,
                            child: Container(
                              width: 96,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: .16),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            bottom: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: CachedNetworkImage(
                                imageUrl: widget.food.imageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                ),
                                errorWidget: (context, url, error) => Container(
                                  color: colorScheme.surfaceContainerHighest,
                                  child: const Icon(
                                    Icons.fastfood_rounded,
                                    size: 34,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  right: 12,
                  child: _CircleButton(
                    icon: widget.isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: widget.isFavorite
                        ? AppColors.tomato
                        : colorScheme.onSurface,
                    background: colorScheme.surface.withValues(alpha: .92),
                    onTap: widget.onFavorite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.background,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background ?? Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }
}
