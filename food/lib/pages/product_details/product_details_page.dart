import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';

import 'package:food/pages/product_details/widget/info_card.dart';
import 'package:food/pages/product_details/widget/suggested_card.dart';
import 'package:food/pages/product_details/widget/animated_tile.dart';

class ProductDetailsPage extends StatefulWidget {
  final ApiModel recipe;
  const ProductDetailsPage({super.key, required this.recipe});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  bool showDetails = false;

  late Future<List<ApiModel>> suggestedFuture;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // جلب وصفات مشابهة من API
    suggestedFuture = ApiClient.fetchSuggestedRecipes(widget.recipe.id);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildQuickInfo(ApiModel recipe) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        InfoCard(Icons.timer, "${recipe.prepTimeMinutes} min prep"),
        InfoCard(Icons.local_fire_department, "${recipe.cookTimeMinutes} min cook"),
        InfoCard(Icons.fastfood, "${recipe.servings} servings"),
        InfoCard(Icons.local_dining, recipe.difficulty),
        InfoCard(Icons.local_fire_department, "${recipe.caloriesPerServing ?? 0} kcal"),
        InfoCard(Icons.flag, recipe.cuisine),
      ],
    );
  }

  Widget _buildSuggestedSection() {
    return SizedBox(
      height: 160,
      child: FutureBuilder<List<ApiModel>>(
        future: suggestedFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final suggested = snapshot.data ?? [];
          if (suggested.isEmpty) return const Center(child: Text("No suggested recipes"));

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: suggested.length,
            itemBuilder: (context, index) {
              final item = suggested[index];
              return SuggestedCard(recipe: item, id: null,, imageUrl: '',, title: '',); // استخدم النسخة المحسّنة من SuggestedCard
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(recipe.name, style: const TextStyle(color: Colors.white)),
              background: Hero(
                tag: "recipe_${recipe.id}",
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      recipe.image.isNotEmpty
                          ? Image.network(recipe.image, fit: BoxFit.cover)
                          : Image.asset("assets/images/placeholder.png", fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FadeTransition(
                opacity: _fadeIn,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  // Price
                  Row(children: [
                    const Icon(Icons.attach_money, color: Colors.green),
                    Text("${recipe.price.toStringAsFixed(2)} EGP",
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  ]),
                  const SizedBox(height: 12),
                  // Rating
                  Row(
                    children: [
                      Row(
                        children: List.generate(
                            5, (i) => Icon(i < recipe.rating.toInt() ? Icons.star : Icons.star_border, color: Colors.amber)),
                      ),
                      const SizedBox(width: 6),
                      Text("(${recipe.reviewCount} Reviews)"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(recipe.description ?? "No description", style: const TextStyle(fontSize: 16, height: 1.5)),
                  const SizedBox(height: 24),
                  const Text("Quick Info", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  const SizedBox(height: 12),
                  _buildQuickInfo(recipe),
                  const SizedBox(height: 30),
                  // Show Details Button
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(showDetails ? Icons.expand_less : Icons.expand_more),
                      label: Text(showDetails ? "Hide Details" : "Show Details"),
                      onPressed: () => setState(() => showDetails = !showDetails),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Ingredients + Instructions
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: showDetails
                        ? Column(
                            key: const ValueKey("details"),
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedTile(
                                title: "Ingredients",
                                children: recipe.ingredients
                                        ?.map((ing) => ListTile(
                                              leading: const Icon(Icons.check_circle, color: Colors.green),
                                              title: Text(ing),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                              const SizedBox(height: 12),
                              AnimatedTile(
                                title: "Instructions",
                                children: recipe.instructions.asMap().entries.map((entry) => ListTile(
                                      leading: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.redAccent,
                                          child: Text("${entry.key + 1}", style: const TextStyle(color: Colors.white))),
                                      title: Text(entry.value),
                                    )).toList(),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(height: 30),
                  const Text("You may also like",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                  const SizedBox(height: 12),
                  _buildSuggestedSection(),
                ]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart),
            label: Text("Buy Now - ${recipe.price.toStringAsFixed(2)} EGP"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            onPressed: () => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("${recipe.name} has been added to cart"))),
          ),
        ),
      ),
    );
  }
}
