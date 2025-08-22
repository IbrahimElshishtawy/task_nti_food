import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/home/widget/product_card.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class HomeProductsPage extends StatefulWidget {
  final Function(ApiModel) onCartAdded;

  const HomeProductsPage({super.key, required this.onCartAdded});

  @override
  State<HomeProductsPage> createState() => _HomeProductsPageState();
}

class _HomeProductsPageState extends State<HomeProductsPage>
    with SingleTickerProviderStateMixin {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;
  final Set<int> favorites = {};

  bool showMenu = false; // 🔹 control menu visibility
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    fetchData();

    // 🔹 Animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiClient.fetchRecipes();
      setState(() {
        recipes = data;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching recipes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleFavorite(int index) {
    setState(() {
      if (favorites.contains(index)) {
        favorites.remove(index);
      } else {
        favorites.add(index);
      }
    });
  }

  void toggleMenu() {
    setState(() {
      showMenu = !showMenu;
      if (showMenu) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        /// 🔹 Slider banners
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

        /// 🔹 Discounts scroll
        SizedBox(
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
        ),
        const SizedBox(height: 16),

        /// 🔹 4 buttons (Menu - Location - Reservation - Dish of the day)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              actionButton(Icons.restaurant_menu, "Menu", toggleMenu),
              actionButton(Icons.location_on, "Location", () {
                debugPrint("Restaurant location");
              }),
              actionButton(Icons.event_seat, "Reserve Table", () {
                debugPrint("Reserve table");
              }),
              actionButton(Icons.local_dining, "Dish of the Day", () {
                debugPrint("Dish of the day");
              }),
            ],
          ),
        ),
        const SizedBox(height: 20),

        /// 🔹 Products list with animation
        if (showMenu)
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recipes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ProductDetailsPage(recipe: recipes[index]),
                        ),
                      );
                    },
                    child: ProductCard(
                      recipe: recipes[index],
                      index: index,
                      favorites: favorites,
                      addToCart: widget.onCartAdded,
                      toggleFavorite: toggleFavorite,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  /// 🔹 Banner item
  Widget bannerItem(String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  /// 🔹 Discount card (image + text)
  Widget discountCard(String imagePath, String text) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Action button (icon + text)
  Widget actionButton(IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(40),
          child: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            child: Icon(icon, color: Colors.redAccent, size: 28),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
