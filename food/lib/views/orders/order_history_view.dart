import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/order_controller.dart';
import '../../core/state/view_state.dart';
import '../../models/order_model.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/order_status_chip.dart';

class OrderHistoryView extends GetView<OrderController> {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
      body: Obx(() {
        switch (controller.historyState.value) {
          case ViewState.loading:
            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) =>
                  const LoadingShimmer(height: 190),
            );
          case ViewState.empty:
            return EmptyState(
              icon: Icons.receipt_long_outlined,
              title: 'No orders yet',
              message:
                  'Your previous orders and live tracking will appear here.',
              actionLabel: 'Order something',
              onAction: () => Get.offNamed(AppRoutes.home),
            );
          case ViewState.error:
            return EmptyState(
              icon: Icons.error_outline_rounded,
              title: 'Could not load orders',
              message: controller.errorMessage.value,
              actionLabel: 'Try again',
              onAction: controller.fetchOrders,
            );
          case ViewState.idle:
          case ViewState.success:
            return RefreshIndicator(
              onRefresh: controller.fetchOrders,
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                itemCount: controller.orders.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  return _OrderCard(order: controller.orders[index]);
                },
              ),
            );
        }
      }),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      order.id,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dateLabel(order.createdAt),
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              OrderStatusChip(status: order.status),
            ],
          ),
          const SizedBox(height: 16),
          _Timeline(status: order.status),
          const SizedBox(height: 16),
          Text(
            order.items
                .map((item) => '${item.quantity}x ${item.food.name}')
                .join('  |  '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Icon(
                Icons.location_on_outlined,
                color: colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  order.address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                CurrencyFormatter.format(order.total),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _dateLabel(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.year}-$month-$day  $hour:$minute';
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    if (status == OrderStatus.cancelled) {
      return Row(
        children: <Widget>[
          const Icon(Icons.cancel_rounded, color: AppColors.tomato),
          const SizedBox(width: 8),
          Text(
            'Order cancelled',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      );
    }

    const steps = <OrderStatus>[
      OrderStatus.pending,
      OrderStatus.preparing,
      OrderStatus.onTheWay,
      OrderStatus.delivered,
    ];
    final activeIndex = steps.indexOf(status);

    return Row(
      children: List<Widget>.generate(steps.length, (index) {
        final active = index <= activeIndex;
        final last = index == steps.length - 1;
        return Expanded(
          child: Row(
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 240),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.leaf
                      : Theme.of(context).colorScheme.outlineVariant,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  active ? Icons.check_rounded : Icons.circle_outlined,
                  color: active
                      ? Colors.white
                      : Theme.of(context).colorScheme.outline,
                  size: 16,
                ),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    height: 3,
                    color: active
                        ? AppColors.leaf
                        : Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
