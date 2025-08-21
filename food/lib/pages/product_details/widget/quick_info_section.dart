// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';

class QuickInfoSection extends StatelessWidget {
  final ApiModel recipe;
  const QuickInfoSection({super.key, required this.recipe});

  Widget _buildCustomCard(
    IconData icon,
    String text,
    Color startColor,
    Color endColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: startColor.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cards = [
      _buildCustomCard(
        Icons.timer,
        "${recipe.prepTimeMinutes} min prep",
        Colors.orange.shade300,
        Colors.deepOrange.shade400,
      ),
      _buildCustomCard(
        Icons.local_fire_department,
        "${recipe.cookTimeMinutes} min cook",
        Colors.redAccent.shade200,
        Colors.redAccent.shade400,
      ),
      _buildCustomCard(
        Icons.fastfood,
        "${recipe.servings} servings",
        Colors.green.shade300,
        Colors.green.shade500,
      ),
      _buildCustomCard(
        Icons.local_dining,
        recipe.difficulty,
        Colors.blue.shade300,
        Colors.blue.shade500,
      ),
      _buildCustomCard(
        Icons.local_fire_department,
        "${recipe.caloriesPerServing} kcal",
        Colors.purple.shade300,
        Colors.purple.shade500,
      ),
      _buildCustomCard(
        Icons.flag,
        recipe.cuisine,
        Colors.teal.shade300,
        Colors.teal.shade500,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "Quick Info",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
        ),
        SizedBox(height: 1),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2.9,
          children: cards,
        ),
      ],
    );
  }
}
