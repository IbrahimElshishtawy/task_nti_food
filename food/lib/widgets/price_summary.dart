import 'package:flutter/material.dart';

import '../utils/currency_formatter.dart';

class PriceSummary extends StatelessWidget {
  const PriceSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
  });

  final double subtotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          _SummaryRow(label: 'Subtotal', value: CurrencyFormatter.format(subtotal)),
          const SizedBox(height: 10),
          _SummaryRow(
            label: 'Delivery fee',
            value: CurrencyFormatter.format(deliveryFee),
          ),
          const Divider(height: 28),
          _SummaryRow(
            label: 'Total',
            value: CurrencyFormatter.format(total),
            isTotal: true,
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: (isTotal ? textTheme.titleLarge : textTheme.titleMedium)
              ?.copyWith(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
