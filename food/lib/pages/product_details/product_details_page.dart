import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/product_details/widget/animated_tile.dart';
import 'package:food/pages/product_details/widget/info_card.dart';
import 'package:food/pages/product_details/widget/suggested_card.dart';

class ProductDetailsPage extends StatefulWidget {
  final ApiModel recipe;
  const ProductDetailsPage({super.key, required this.recipe});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  bool showDetails = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              background: Hero(
                tag: "recipe_${recipe.id}",
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(recipe.image, fit: BoxFit.cover),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                            ],
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
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeTransition(
                opacity: _fadeIn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Colors.green,
                          size: 24,
                        ),
                        Text(
                          "${recipe.price.toStringAsFixed(2)} EGP",
                          style: const TextStyle(
                            fontSize: 22,
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Row(
                          children: List.generate(
                            5,
                            (i) => Icon(
                              i < recipe.rating.toInt()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text("(${recipe.reviewCount} Reviews)"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      recipe.description ?? "No description available.",
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        InfoCard(
                          Icons.timer,
                          "${recipe.prepTimeMinutes} دق تحضير",
                        ),
                        InfoCard(
                          Icons.local_fire_department,
                          "${recipe.cookTimeMinutes} دق طبخ",
                        ),
                        InfoCard(Icons.fastfood, "${recipe.servings} أفراد"),
                        InfoCard(Icons.local_dining, recipe.difficulty),
                        InfoCard(
                          Icons.local_fire_department,
                          "${recipe.caloriesPerServing} kcal",
                        ),
                        InfoCard(Icons.flag, recipe.cuisine),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton.icon(
                        icon: Icon(
                          showDetails ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                        ),
                        label: Text(
                          showDetails ? "إخفاء التفاصيل" : "عرض التفاصيل",
                          style: const TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            showDetails = !showDetails;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: showDetails
                          ? Column(
                              key: const ValueKey("details"),
                              children: [
                                AnimatedTile(
                                  title: "المكونات",
                                  children: recipe.ingredients
                                      .map(
                                        (ing) => ListTile(
                                          leading: const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                          ),
                                          title: Text(ing),
                                        ),
                                      )
                                      .toList(),
                                ),
                                const SizedBox(height: 10),
                                AnimatedTile(
                                  title: "خطوات التحضير",
                                  children: recipe.instructions
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => ListTile(
                                          leading: CircleAvatar(
                                            radius: 14,
                                            backgroundColor: Colors.redAccent,
                                            child: Text(
                                              "${entry.key + 1}",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          title: Text(entry.value),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "قد يعجبك أيضًا",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          SuggestedCard("assets/images/pasta.jpg", "Pasta"),
                          SuggestedCard("assets/images/burger.jpg", "Burger"),
                          SuggestedCard("assets/images/salad.jpg", "Salad"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ElevatedButton.icon(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${recipe.name} تمت إضافته للعربة")),
              );
            },
            label: Text(
              "اشترى الآن - ${recipe.price.toStringAsFixed(2)} EGP",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
