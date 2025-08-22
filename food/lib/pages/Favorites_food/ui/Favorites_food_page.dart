import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<ApiModel> favoriteRecipes;

  const FavoritesPage({super.key, required this.favoriteRecipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Favorites",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepOrange,
      ),
      body: favoriteRecipes.isEmpty
          ? const Center(
              child: Text(
                "No favorite recipes yet!",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: favoriteRecipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final recipe = favoriteRecipes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsPage(recipe: recipe),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      shadowColor: Colors.black26,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                recipe.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image, size: 50),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recipe.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 16,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      recipe.rating?.toStringAsFixed(1) ??
                                          "4.5", // في حال مفيش rating
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
