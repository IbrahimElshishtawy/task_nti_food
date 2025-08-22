import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  final String method;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const PaymentCard({
    super.key,
    required this.method,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? Colors.deepOrangeAccent : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? Colors.deepOrange : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? Colors.white : Colors.deepOrange),
            const SizedBox(height: 8),
            Text(
              method,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
