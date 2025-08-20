import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';

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
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

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
      appBar: AppBar(
        title: Text(recipe.name, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.redAccent,
        elevation: 4,
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: _controller,
              curve: const Interval(0.6, 1, curve: Curves.elasticOut),
            ),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${recipe.name} added to cart")),
                );
              },
              label: Text(
                "اشترى الآن - ${recipe.price.toStringAsFixed(2)} EGP",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // صورة المنتج مع Hero + Fade
            Hero(
              tag: "recipe_${recipe.id}",
              child: Stack(
                children: [
                  FadeTransition(
                    opacity: _fadeIn,
                    child: Image.network(
                      recipe.image,
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
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

            // باقي العناصر مع Slide + Fade
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FadeTransition(
                opacity: _fadeIn,
                child: SlideTransition(
                  position: _slideUp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // الاسم + السعر
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              recipe.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
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
                      const SizedBox(height: 8),

                      // التقييم + عدد الريفيوهات
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
                                size: 22,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text("(${recipe.reviewCount} Reviews)"),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // الوصف
                      Text(
                        recipe.description ?? "No description available.",
                        style: const TextStyle(fontSize: 16, height: 1.4),
                      ),
                      const SizedBox(height: 20),

                      // معلومات إضافية (Chips)
                      Wrap(
                        spacing: 16,
                        runSpacing: 10,
                        children: [
                          infoChip(
                            Icons.timer,
                            "${recipe.prepTimeMinutes} min Prep",
                          ),
                          infoChip(
                            Icons.local_fire_department,
                            "${recipe.cookTimeMinutes} min Cook",
                          ),
                          infoChip(
                            Icons.fastfood,
                            "${recipe.servings} Servings",
                          ),
                          infoChip(Icons.local_dining, recipe.difficulty),
                          infoChip(
                            Icons.local_fire_department,
                            "${recipe.caloriesPerServing} kcal",
                          ),
                          infoChip(Icons.flag, recipe.cuisine),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // ✅ عرض المكونات بدون اختيار
                      _animatedTile(
                        "المكونات",
                        recipe.ingredients
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

                      // 📖 خطوات التحضير مع Stepper
                      const SizedBox(height: 8),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExpansionTile(
                            initiallyExpanded: true,
                            title: const Text(
                              "خطوات التحضير",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            children: [
                              Stepper(
                                physics: const NeverScrollableScrollPhysics(),
                                currentStep: 0,
                                controlsBuilder: (context, details) =>
                                    const SizedBox(),
                                steps: recipe.instructions
                                    .asMap()
                                    .entries
                                    .map(
                                      (entry) => Step(
                                        title: Text(
                                          "الخطوة ${entry.key + 1}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: Text(entry.value),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoChip(IconData icon, String text) {
    return Chip(
      avatar: Icon(icon, color: Colors.white, size: 18),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.redAccent,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  Widget _animatedTile(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        children: children,
      ),
    );
  }
}
