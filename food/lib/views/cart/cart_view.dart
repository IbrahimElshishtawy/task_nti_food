import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../models/cart_item_model.dart';
import '../../routes/app_routes.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/price_summary.dart';
import '../../widgets/quantity_stepper.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return EmptyState(
            icon: Icons.shopping_bag_outlined,
            title: 'Your cart is light',
            message: 'Add meals from the home page and checkout in seconds.',
            actionLabel: 'Explore menu',
            onAction: () => Get.offNamed(AppRoutes.home),
          );
        }

        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                itemCount: controller.items.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _CartItemCard(item: controller.items[index]);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                20,
                14,
                20,
                MediaQuery.paddingOf(context).bottom + 14,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .07),
                    blurRadius: 24,
                    offset: const Offset(0, -10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  PriceSummary(
                    subtotal: controller.subtotal,
                    deliveryFee: controller.deliveryFee,
                    total: controller.total,
                  ),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.checkout),
                    icon: const Icon(Icons.lock_rounded),
                    label: Text('Checkout ${controller.totalLabel}'),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: item.food.imageUrl,
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
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.food.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 7),
                Text(
                  CurrencyFormatter.format(item.lineTotal),
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                QuantityStepper(
                  quantity: item.quantity,
                  onIncrement: () => cartController.increment(item.food.id),
                  onDecrement: () => cartController.decrement(item.food.id),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => cartController.removeItem(item.food.id),
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }
}
