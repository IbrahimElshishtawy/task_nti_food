import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/order_model.dart';

class PaymentOptionTile extends StatelessWidget {
  const PaymentOptionTile({
    super.key,
    required this.method,
    required this.selected,
    required this.onTap,
  });

  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: .12)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: selected ? colorScheme.primary : colorScheme.outlineVariant,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: selected
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHighest,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _icon,
                color: selected ? Colors.white : colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                _label.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? colorScheme.primary : colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }

  IconData get _icon {
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        return Icons.payments_outlined;
      case PaymentMethod.creditCard:
        return Icons.credit_card_rounded;
      case PaymentMethod.wallet:
        return Icons.account_balance_wallet_outlined;
    }
  }

  String get _label {
    switch (method) {
      case PaymentMethod.cashOnDelivery:
        return 'cash_on_delivery';
      case PaymentMethod.creditCard:
        return 'credit_card';
      case PaymentMethod.wallet:
        return 'wallet';
    }
  }
}
