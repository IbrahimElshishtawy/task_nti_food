import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class SearchPage extends StatefulWidget {
  final List<ApiModel> recipes;

  const SearchPage({super.key, required this.recipes});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<ApiModel> filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    filteredRecipes = widget.recipes;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredRecipes = widget.recipes
          .where((recipe) => recipe.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: const Icon(Icons.search, color: Colors.redAccent),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: filteredRecipes.isEmpty
                ? const Center(
                    child: Text(
                      "No food found",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GridView.builder(
                      itemCount: filteredRecipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.7,
                          ),
                      itemBuilder: (context, index) {
                        final recipe = filteredRecipes[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailsPage(recipe: recipe),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 3,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    recipe.image,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.image, size: 50),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        recipe.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${recipe.cuisine} • ${recipe.caloriesPerServing} cal",
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            recipe.rating.toStringAsFixed(1),
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
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
          ),
        ],
      ),
    );
  }
}
