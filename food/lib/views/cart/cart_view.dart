import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../models/cart_item_model.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
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
        title: Text('cart'.tr),
        actions: <Widget>[
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.search),
            icon: const Icon(Icons.search_rounded),
            tooltip: 'search'.tr,
          ),
          Obx(() {
            if (controller.items.isEmpty) return const SizedBox.shrink();
            return IconButton(
              onPressed: controller.clearCart,
              icon: const Icon(Icons.delete_sweep_rounded),
              tooltip: 'remove'.tr,
            );
          }),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
      body: Obx(() {
        if (controller.items.isEmpty) {
          return EmptyState(
            icon: Icons.shopping_bag_outlined,
            title: 'cart_light'.tr,
            message: 'cart_light_message'.tr,
            actionLabel: 'explore_menu'.tr,
            onAction: () => Get.offNamed(AppRoutes.home),
          );
        }

        return SafeArea(
          bottom: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
                  itemCount: controller.items.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _CartOverview(
                        itemCount: controller.totalItems,
                        subtotal: controller.subtotal,
                        deliveryFee: controller.deliveryFee,
                        total: controller.total,
                      );
                    }
                    return _CartItemCard(item: controller.items[index - 1]);
                  },
                ),
              ),
              _CheckoutPanel(
                subtotal: controller.subtotal,
                deliveryFee: controller.deliveryFee,
                total: controller.total,
                totalLabel: controller.totalLabel,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _CartOverview extends StatelessWidget {
  const _CartOverview({
    required this.itemCount,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final int itemCount;
  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.primary, AppColors.butter],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: .2),
            blurRadius: 28,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 340;
          final titleBlock = _OverviewTitle(
            itemCount: itemCount,
            subtotal: subtotal,
            deliveryFee: deliveryFee,
          );
          final totalBlock = _OverviewTotal(
            colorScheme: colorScheme,
            total: total,
          );
          final icon = Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_bag_rounded,
              color: Colors.white,
              size: 30,
            ),
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    icon,
                    const SizedBox(width: 14),
                    Expanded(child: titleBlock),
                  ],
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: totalBlock,
                ),
              ],
            );
          }

          return Row(
            children: <Widget>[
              icon,
              const SizedBox(width: 14),
              Expanded(child: titleBlock),
              const SizedBox(width: 12),
              totalBlock,
            ],
          );
        },
      ),
    );
  }
}

class _OverviewTitle extends StatelessWidget {
  const _OverviewTitle({
    required this.itemCount,
    required this.subtotal,
    required this.deliveryFee,
  });

  final int itemCount;
  final double subtotal;
  final double deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'cart'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          '${'quantity'.tr}: $itemCount',
          style: TextStyle(
            color: Colors.white.withValues(alpha: .86),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _OverviewPill(
              label: 'subtotal'.tr,
              value: CurrencyFormatter.format(subtotal),
            ),
            _OverviewPill(
              label: 'delivery_fee'.tr,
              value: CurrencyFormatter.format(deliveryFee),
            ),
          ],
        ),
      ],
    );
  }
}

class _OverviewTotal extends StatelessWidget {
  const _OverviewTotal({required this.colorScheme, required this.total});

  final ColorScheme colorScheme;
  final double total;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .92),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'total'.tr,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              CurrencyFormatter.format(total),
              style: TextStyle(
                color: colorScheme.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewPill extends StatelessWidget {
  const _OverviewPill({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .17),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Text(
          '$label  $value',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _CheckoutPanel extends StatelessWidget {
  const _CheckoutPanel({
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.totalLabel,
  });

  final double subtotal;
  final double deliveryFee;
  final double total;
  final String totalLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        14,
        20,
        MediaQuery.paddingOf(context).bottom + 14,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 26,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          PriceSummary(
            subtotal: subtotal,
            deliveryFee: deliveryFee,
            total: total,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.checkout),
              icon: const Icon(Icons.lock_rounded),
              label: Text('${'checkout'.tr} $totalLabel'),
            ),
          ),
        ],
      ),
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

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.toNamed(AppRoutes.details, arguments: item.food),
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: .045),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: 'food-${item.food.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22),
                          child: CachedNetworkImage(
                            imageUrl: item.food.imageUrl,
                            width: 96,
                            height: 104,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              width: 96,
                              height: 104,
                              color: colorScheme.surfaceContainerHighest,
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 96,
                              height: 104,
                              color: colorScheme.surfaceContainerHighest,
                              child: const Icon(Icons.fastfood_rounded),
                            ),
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        top: 8,
                        end: 8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: Text(
                              'x${item.quantity}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item.food.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 10,
                          runSpacing: 6,
                          children: <Widget>[
                            _FoodMeta(
                              icon: Icons.star_rounded,
                              value: item.food.rating.toStringAsFixed(1),
                              iconColor: AppColors.butter,
                            ),
                            _FoodMeta(
                              icon: Icons.schedule_rounded,
                              value: item.food.preparationTime,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      CurrencyFormatter.format(item.lineTotal),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  QuantityStepper(
                    quantity: item.quantity,
                    onIncrement: () => cartController.increment(item.food.id),
                    onDecrement: () => cartController.decrement(item.food.id),
                  ),
                  const SizedBox(width: 4),
                  IconButton(
                    onPressed: () => cartController.removeItem(item.food.id),
                    icon: const Icon(Icons.delete_outline_rounded),
                    tooltip: 'remove'.tr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FoodMeta extends StatelessWidget {
  const _FoodMeta({required this.icon, required this.value, this.iconColor});

  final IconData icon;
  final String value;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 16, color: iconColor ?? colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 86),
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
