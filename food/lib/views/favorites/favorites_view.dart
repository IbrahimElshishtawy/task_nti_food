import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/favorites_controller.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/food_list_card.dart';

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return EmptyState(
            icon: Icons.favorite_border_rounded,
            title: 'No favorites yet',
            message: 'Save meals you love and they will appear here.',
            actionLabel: 'Browse meals',
            onAction: () => Get.offNamed(AppRoutes.home),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          itemCount: controller.favorites.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final food = controller.favorites[index];
            return FoodListCard(
              food: food,
              isFavorite: true,
              onFavorite: () => controller.removeFavorite(food.id),
              onCart: () => cartController.addItem(food),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () => controller.removeFavorite(food.id),
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: 'Remove',
                  ),
                  IconButton.filled(
                    onPressed: () => cartController.addItem(food),
                    icon: const Icon(Icons.add_shopping_cart_rounded),
                    tooltip: 'Add to cart',
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
