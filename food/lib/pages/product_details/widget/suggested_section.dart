import 'package:flutter/material.dart';
import 'package:food/pages/product_details/product_details_page.dart';
import '../controls/product_details_controller.dart';

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

    // 🔥 عرض أفقي بالكروت بشكل مربع بحواف ناعمة
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: controller.suggestedRecipes.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = controller.suggestedRecipes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsPage(recipe: item),
                ),
              );
            },
            child: Container(
              width: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16), // 🔥 حواف ناعمة
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // الصورة المربعة
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item.image,
                      height: 120,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // العنوان
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
