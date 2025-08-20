import 'package:flutter/material.dart';
import 'package:food/pages/product_details/widget/details_section.dart';
import 'package:food/pages/product_details/widget/quick_buy_section.dart';
import 'package:food/pages/product_details/widget/quick_info_section.dart';
import 'package:food/pages/product_details/widget/suggested_section.dart';
import '../../data/api_model.dart';

import 'controls/product_details_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  final ApiModel recipe;
  const ProductDetailsPage({super.key, required this.recipe});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeIn;
  late final ProductDetailsController controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    controller = ProductDetailsController(recipe: widget.recipe);
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    controller.dispose();
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
            expandedHeight: 280,
            pinned: true,
            backgroundColor: Colors.deepOrange,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                recipe.name,
                style: const TextStyle(color: Colors.white),
              ),
              background: Hero(
                tag: "recipe_${recipe.id}",
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      recipe.image.isNotEmpty
                          ? Image.network(recipe.image, fit: BoxFit.cover)
                          : Image.asset(
                              "assets/images/placeholder.png",
                              fit: BoxFit.cover,
                            ),
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
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // السعر والشراء
                  QuickBuySection(recipe: recipe),

                  const SizedBox(height: 20),

                  // تقييم النجوم
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
                  const SizedBox(height: 6),
                  Text("(${recipe.reviewCount} Reviews)"),

                  const SizedBox(height: 20),

                  // Quick Info
                  QuickInfoSection(recipe: recipe),

                  const SizedBox(height: 30),

                  // Show / Hide Details
                  Center(
                    child: ElevatedButton.icon(
                      icon: Icon(
                        controller.showDetails
                            ? Icons.expand_less
                            : Icons.expand_more,
                      ),
                      label: Text(
                        controller.showDetails
                            ? "Hide Details"
                            : "Show Details",
                      ),
                      onPressed: () => controller.toggleDetails(),
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: controller.showDetails
                        ? DetailsSection(recipe: recipe)
                        : const SizedBox(),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "You may also like",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SuggestedSection(controller: controller),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
