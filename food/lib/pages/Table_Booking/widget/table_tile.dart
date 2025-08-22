import 'package:flutter/material.dart';

class TableTile extends StatelessWidget {
  final int index;
  final bool isBooked;
  final VoidCallback onTap;

  const TableTile({
    super.key,
    required this.index,
    required this.isBooked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: isBooked
              ? const LinearGradient(
                  colors: [Colors.redAccent, Colors.red],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Colors.white, Color(0xFFF5F5F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          border: Border.all(
            color: isBooked ? Colors.red.shade700 : Colors.redAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(-2, -2),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Table",
                style: TextStyle(
                  color: isBooked ? Colors.white : Colors.redAccent.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${index + 1}",
                style: TextStyle(
                  color: isBooked ? Colors.white : Colors.redAccent.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
