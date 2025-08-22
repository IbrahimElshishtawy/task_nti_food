import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';

class CartItemCard extends StatelessWidget {
  final ApiModel item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // صورة المنتج
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // اسم المنتج والسعر
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "\$${item.price.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
          ),
          // أزرار زيادة ونقصان الكمية
          Container(
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: onDecrease,
                  color: Colors.orange,
                  splashRadius: 20,
                ),
                Text(
                  "${item.quantity}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: onIncrease,
                  color: Colors.orange,
                  splashRadius: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
