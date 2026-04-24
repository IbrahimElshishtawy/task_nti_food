import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/food_model.dart';
import '../routes/app_routes.dart';
import '../theme/app_colors.dart';
import '../utils/currency_formatter.dart';

class FoodListCard extends StatelessWidget {
  const FoodListCard({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.onFavorite,
    required this.onCart,
    this.trailing,
  });

  final FoodModel food;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onCart;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.details, arguments: food),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'food-${food.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: food.imageUrl,
                  width: 92,
                  height: 92,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 92,
                    height: 92,
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 92,
                    height: 92,
                    color: colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.fastfood_rounded),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    food.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
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
                        food.rating.toStringAsFixed(1),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          CurrencyFormatter.format(food.price),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            trailing ??
                Column(
                  children: <Widget>[
                    IconButton(
                      onPressed: onFavorite,
                      icon: Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: isFavorite ? AppColors.tomato : null,
                      ),
                      tooltip: 'Favorite',
                    ),
                    IconButton.filled(
                      onPressed: onCart,
                      icon: const Icon(Icons.add_rounded),
                      tooltip: 'Add to cart',
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}
