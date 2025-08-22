// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';

class DetailsSection extends StatelessWidget {
  final ApiModel recipe;
  const DetailsSection({super.key, required this.recipe});

  void _showBottomSheet(
    BuildContext context,
    String title,
    List<String> items, {
    bool numbered = false,
  }) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          // ✅ يخلي المحتوى يلف لو طويل
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...items.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        numbered ? Icons.check_circle : Icons.circle,
                        size: 18,
                        color: Colors.deepOrange,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          numbered
                              ? "${entry.key + 1}. ${entry.value}"
                              : entry.value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ingredients Box
        GestureDetector(
          onTap: () =>
              _showBottomSheet(context, "Ingredients", recipe.ingredients),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: const [
                Icon(Icons.shopping_basket, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  "Ingredients (Tap to view)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Instructions Box
        GestureDetector(
          onTap: () => _showBottomSheet(
            context,
            "Instructions",
            recipe.instructions,
            numbered: true,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: const [
                Icon(Icons.list_alt, color: Colors.redAccent),
                SizedBox(width: 8),
                Text(
                  "Instructions (Tap to view)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
