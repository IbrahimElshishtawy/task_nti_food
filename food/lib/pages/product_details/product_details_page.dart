import 'package:flutter/material.dart';
import 'package:food/pages/product_details/widget/Recipe_AppBar.dart';
import 'package:food/pages/product_details/widget/details_section.dart';
import 'package:food/pages/product_details/widget/quick_buy_section.dart';
import 'package:food/pages/product_details/widget/quick_info_section.dart';
import 'package:food/pages/product_details/widget/suggested_section.dart';
import '../../data/api_model.dart';
import 'controls/product_details_controller.dart';
import '../cart/cart_page.dart'; // <-- استدعاء صفحة السلة

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

  // قائمة السلة المحلية لهذه الصفحة
  final List<ApiModel> cartItems = [];

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

  void addToCart(ApiModel product) {
    setState(() {
      final existingIndex = cartItems.indexWhere(
        (item) => item.id == product.id,
      );
      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity++;
      } else {
        cartItems.add(
          ApiModel(
            id: product.id,
            name: product.name,
            ingredients: product.ingredients,
            instructions: product.instructions,
            prepTimeMinutes: product.prepTimeMinutes,
            cookTimeMinutes: product.cookTimeMinutes,
            servings: product.servings,
            difficulty: product.difficulty,
            cuisine: product.cuisine,
            caloriesPerServing: product.caloriesPerServing,
            tags: product.tags,
            userId: product.userId,
            image: product.image,
            rating: product.rating,
            reviewCount: product.reviewCount,
            mealType: product.mealType,
            price: product.price,
            quantity: 1,
          ),
        );
      }
    });

    // الذهاب إلى صفحة السلة
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CartPage(cartItems: cartItems)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: CustomScrollView(
        slivers: [
          RecipeAppBar(recipe: recipe, fadeIn: _fadeIn),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // تعديل QuickBuySection
                  QuickBuySection(
                    recipe: recipe,
                    cartItems: cartItems,
                    onCartAdded: addToCart,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < recipe.rating.toInt()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "(${recipe.reviewCount} Reviews)",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  QuickInfoSection(recipe: recipe),
                  const SizedBox(height: 16),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: DetailsSection(recipe: recipe),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      "You may also like",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange.shade400,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
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
