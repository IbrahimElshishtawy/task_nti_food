// Payment Section Widget
import 'package:flutter/material.dart';
import 'package:food/pages/cart/widget/payment_card.dart';

class PaymentSection extends StatelessWidget {
  final String paymentMethod;
  final Function(String) onSelect;

  const PaymentSection({
    super.key,
    required this.paymentMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.orange.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Payment Method",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                PaymentCard(
                  method: "Cash",
                  icon: Icons.money,
                  selected: paymentMethod == "Cash",
                  onTap: () => onSelect("Cash"),
                ),
                PaymentCard(
                  method: "Credit Card",
                  icon: Icons.credit_card,
                  selected: paymentMethod == "Credit Card",
                  onTap: () => onSelect("Credit Card"),
                ),
                PaymentCard(
                  method: "PayPal",
                  icon: Icons.account_balance_wallet,
                  selected: paymentMethod == "PayPal",
                  onTap: () => onSelect("PayPal"),
                ),
                PaymentCard(
                  method: "Wallet",
                  icon: Icons.account_balance,
                  selected: paymentMethod == "Wallet",
                  onTap: () => onSelect("Wallet"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
