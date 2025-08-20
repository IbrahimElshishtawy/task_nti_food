import 'package:flutter/material.dart';
import '../controls/product_details_controller.dart';
import 'suggested_card.dart';

class SuggestedSection extends StatelessWidget {
  final ProductDetailsController controller;
  const SuggestedSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.error != null) {
      return Center(child: Text("Error: ${controller.error}"));
    }
    if (controller.suggestedRecipes.isEmpty) {
      return const Center(child: Text("No suggested recipes"));
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.suggestedRecipes.length,
        itemBuilder: (context, index) {
          final item = controller.suggestedRecipes[index];
          return SuggestedCard(
            recipe: item,
            id: item.id,
            imageUrl: item.image,
            title: item.name,
          );
        },
      ),
    );
  }
}
