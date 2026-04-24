import 'package:flutter/material.dart';

import '../models/order_model.dart';
import '../theme/app_colors.dart';

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = _color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }

  Color get _color {
    switch (status) {
      case OrderStatus.pending:
        return AppColors.butter;
      case OrderStatus.preparing:
        return AppColors.primary;
      case OrderStatus.onTheWay:
        return AppColors.mint;
      case OrderStatus.delivered:
        return AppColors.leaf;
      case OrderStatus.cancelled:
        return AppColors.tomato;
    }
  }
}
