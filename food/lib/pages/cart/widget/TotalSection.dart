// Total & Place Order Widget
import 'package:flutter/material.dart';

class TotalSection extends StatelessWidget {
  final double totalPrice;
  final String paymentMethod;
  final VoidCallback onCreditCard;
  final VoidCallback onPayPal;
  final VoidCallback onWallet;
  final VoidCallback onCash;

  const TotalSection({
    super.key,
    required this.totalPrice,
    required this.paymentMethod,
    required this.onCreditCard,
    required this.onPayPal,
    required this.onWallet,
    required this.onCash,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Total: \$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              switch (paymentMethod) {
                case "Wallet":
                  onWallet();
                  break;
                case "Credit Card":
                  onCreditCard();
                  break;
                case "PayPal":
                  onPayPal();
                  break;
                default:
                  onCash();
              }
            },
            child: const Text(
              "Place Order",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
