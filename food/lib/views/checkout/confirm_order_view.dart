import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/payment_controller.dart';
import '../../core/state/view_state.dart';
import '../../routes/app_routes.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/payment_option_tile.dart';
import '../../widgets/price_summary.dart';

class ConfirmOrderView extends GetView<OrderController> {
  const ConfirmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final paymentController = Get.find<PaymentController>();

    return Scaffold(
      appBar: AppBar(title: Text('confirm_order'.tr)),
      body: Obx(() {
        if (cartController.items.isEmpty) {
          return EmptyState(
            icon: Icons.shopping_bag_outlined,
            title: 'cart_empty'.tr,
            message: 'checkout_empty_message'.tr,
            actionLabel: 'back_to_menu'.tr,
            onAction: () => Get.offNamed(AppRoutes.home),
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: <Widget>[
            _CheckoutSection(
              title: 'delivery_address'.tr,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.savedAddresses.map((address) {
                      return Obx(() {
                        final selected =
                            controller.selectedAddress.value == address;
                        return ChoiceChip(
                          selected: selected,
                          label: Text(address),
                          onSelected: (_) => controller.selectAddress(address),
                        );
                      });
                    }).toList(),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: controller.addressController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      hintText: 'delivery_notes_hint'.tr,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _CheckoutSection(
              title: 'payment_method'.tr,
              action: TextButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.paymentMethods),
                icon: const Icon(Icons.edit_rounded),
                label: Text('change'.tr),
              ),
              child: Obx(
                () => PaymentOptionTile(
                  method: paymentController.selectedMethod.value,
                  selected: true,
                  onTap: () => Get.toNamed(AppRoutes.paymentMethods),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _CheckoutSection(
              title: 'order_summary'.tr,
              child: PriceSummary(
                subtotal: cartController.subtotal,
                deliveryFee: cartController.deliveryFee,
                total: cartController.total,
              ),
            ),
            const SizedBox(height: 18),
            Obx(() {
              final loading =
                  controller.checkoutState.value == ViewState.loading;
              return FilledButton.icon(
                onPressed: loading ? null : controller.submitOrder,
                icon: loading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.check_circle_rounded),
                label: Text(loading ? 'sending_order'.tr : 'place_order'.tr),
              );
            }),
            Obx(() {
              if (controller.checkoutState.value != ViewState.error) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  controller.errorMessage.value,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  const _CheckoutSection({
    required this.title,
    required this.child,
    this.action,
  });

  final String title;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (action != null) action!,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}
