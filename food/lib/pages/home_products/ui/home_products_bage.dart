import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/Favorites_food/ui/Favorites_food_page.dart';

import 'package:food/pages/home_products/widget/banner_item.dart';
import 'package:food/pages/home_products/widget/discount_card.dart';
import 'package:food/pages/home_products/widget/home_actions.dart';
import 'package:food/pages/home_products/widget/products_list.dart';

class HomeProductsPage extends StatefulWidget {
  final Function(ApiModel) onCartAdded;

  const HomeProductsPage({super.key, required this.onCartAdded});

  @override
  State<HomeProductsPage> createState() => _HomeProductsPageState();
}

class _HomeProductsPageState extends State<HomeProductsPage>
    with TickerProviderStateMixin {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;
  final Set<int> favorites = {};
  bool showMenu = false;

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _wheelController;

  @override
  void initState() {
    super.initState();
    fetchData();
    _initAnimations();
  }

  void _initAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween(
      begin: const Offset(0, .1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _wheelController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _wheelController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiClient.fetchRecipes();
      setState(() {
        recipes = data;
        isLoading = false;
      });
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  void toggleFavorite(int i) => setState(
    () => favorites.contains(i) ? favorites.remove(i) : favorites.add(i),
  );

  void toggleMenu() => setState(() {
    if (showMenu) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    showMenu = !showMenu;
  });

  void goToFavorites() {
    List<ApiModel> favoriteRecipes = favorites.map((i) => recipes[i]).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FavoritesPage(
          favoriteRecipes: favoriteRecipes,
          toggleFavorite: (recipeIndex) {
            setState(() {
              int recipeId = recipes.indexOf(favoriteRecipes[recipeIndex]);
              favorites.remove(recipeId);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView(
            children: [
              bannerItem("assets/image/food1.jpeg"),
              bannerItem("assets/image/food2.jpeg"),
              bannerItem("assets/image/foodpeple.png"),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildDiscounts(),
        const SizedBox(height: 16),
        HomeActions(
          toggleMenu: toggleMenu,
          wheelController: _wheelController,
          goToFavorites: goToFavorites,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 900),
            transitionBuilder: (child, animation) {
              final slide = Tween<Offset>(
                begin: const Offset(-0.2, 0),
                end: Offset.zero,
              ).animate(animation);
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(position: slide, child: child),
              );
            },
            child: showMenu
                ? ListView.builder(
                    key: const ValueKey(1),
                    padding: const EdgeInsets.all(12),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];

                      return TweenAnimationBuilder(
                        duration: Duration(milliseconds: 300 + (index * 100)),
                        tween: Tween<double>(begin: 0, end: 1),
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(-50 * (1 - value), 0),
                              child: child,
                            ),
                          );
                        },
                        child: ProductsList(
                          recipes: [recipe],
                          favorites: favorites,
                          fadeAnimation: _fadeAnimation,
                          slideAnimation: _slideAnimation,
                          onCartAdded: widget.onCartAdded,
                          toggleFavorite: toggleFavorite,
                        ),
                      );
                    },
                  )
                : const SizedBox(key: ValueKey(2)),
          ),
        ),
      ],
    );
  }

  Widget _buildDiscounts() => SizedBox(
    height: 120,
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        discountCard(
          "assets/image/foodpeple.png",
          "Discount for the first 10 reservations",
        ),
        discountCard("assets/image/food1.jpeg", "Pizza special discount"),
        discountCard("assets/image/food2.jpeg", "Drinks discount offer"),
        discountCard(
          "assets/image/foodpeple.png",
          "Discount on large tables (7+ people)",
        ),
      ],
    ),
  );
}
