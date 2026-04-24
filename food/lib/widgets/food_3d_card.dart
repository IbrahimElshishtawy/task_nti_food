import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';

class Food3DCard extends StatefulWidget {
  const Food3DCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onCart,
  });

  final FoodModel food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onCart;

  @override
  State<Food3DCard> createState() => _Food3DCardState();
}

class _Food3DCardState extends State<Food3DCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: () => Get.toNamed(AppRoutes.details, arguments: widget.food),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        transformAlignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateX(_pressed ? 0.025 : -0.035)
          ..rotateY(_pressed ? -0.025 : 0.045),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(28),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _pressed ? .09 : .18),
              blurRadius: _pressed ? 18 : 34,
              offset: Offset(0, _pressed ? 10 : 22),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        colorScheme.surface,
                        colorScheme.primary.withValues(alpha: .08),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Positioned.fill(
                            top: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.butter.withValues(alpha: .16),
                                borderRadius: BorderRadius.circular(26),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Hero(
                              tag: 'food-${widget.food.id}',
                              child: Transform.rotate(
                                angle: -math.pi / 52,
                                child: CachedNetworkImage(
                                  imageUrl: widget.food.imageUrl,
                                  fit: BoxFit.cover,
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(28),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      color:
                                          colorScheme.surfaceContainerHighest,
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          color: colorScheme
                                              .surfaceContainerHighest,
                                          borderRadius: BorderRadius.circular(
                                            28,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.fastfood_rounded,
                                        ),
                                      ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: _CircleButton(
                              icon: widget.isFavorite
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: widget.isFavorite
                                  ? AppColors.tomato
                                  : colorScheme.onSurface,
                              onTap: widget.onFavorite,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      widget.food.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.butter,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.food.rating.toStringAsFixed(1),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 10),
                        Icon(
                          Icons.schedule_rounded,
                          color: colorScheme.onSurfaceVariant,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            widget.food.prepTime,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            CurrencyFormatter.format(widget.food.price),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.w900,
                                ),
                          ),
                        ),
                        _CircleButton(
                          icon: Icons.add_shopping_cart_rounded,
                          color: Colors.white,
                          background: colorScheme.primary,
                          onTap: widget.onCart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
  final Color? background;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          background ??
          Theme.of(context).colorScheme.surface.withValues(alpha: .92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Icon(icon, color: color, size: 21),
        ),
      ),
    );
  }
}
