import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'info_card.dart';

class QuickInfoSection extends StatelessWidget {
  final ApiModel recipe;
  const QuickInfoSection({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Info",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            InfoCard(Icons.timer, "${recipe.prepTimeMinutes} min prep"),
            InfoCard(
              Icons.local_fire_department,
              "${recipe.cookTimeMinutes} min cook",
            ),
            InfoCard(Icons.fastfood, "${recipe.servings} servings"),
            InfoCard(Icons.local_dining, recipe.difficulty),
            InfoCard(
              Icons.local_fire_department,
              "${recipe.caloriesPerServing} kcal",
            ),
            InfoCard(Icons.flag, recipe.cuisine),
          ],
        ),
      ],
    );
  }
}
