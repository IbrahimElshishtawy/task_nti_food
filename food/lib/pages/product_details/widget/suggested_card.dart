import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class SuggestedCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;

  const SuggestedCard({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required ApiModel recipe,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // نفتح صفحة المنتج عند الضغط
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsPage(
              recipe: ApiModel(
                id: id,
                name: title,
                image: imageUrl,
                price: 0,
                rating: 0,
                reviewCount: 0,
                prepTimeMinutes: 0,
                cookTimeMinutes: 0,
                servings: 0,
                difficulty: "",
                caloriesPerServing: 0,
                cuisine: "",
                instructions: [],
                ingredients: [],
                tags: [],
                userId: 0,
                mealType: [],
              ),
            ),
          ),
        );
      },
      child: Container(
        width: 120,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(8),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
