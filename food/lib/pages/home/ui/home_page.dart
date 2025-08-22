import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/Favorites_food/ui/Favorites_food_page.dart';

import 'package:food/pages/home_products/ui/home_products_bage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;
  int currentIndex = 2; // البداية على الصفحة الرئيسية
  final Set<int> favorites = {};

  @override
  Widget build(BuildContext context) {
    final pages = [
      FavoritesPage(favoriteRecipes: const [], toggleFavorite: (index) {}),
      const Center(child: Text("Cart Page")),
      HomeProductsPage(
        onCartAdded: (ApiModel recipe) {
          setState(() => cartCount++);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${recipe.name} added to cart")),
          );
        },
      ),
      const Center(child: Text("Search Page")),
      const Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          ["Favorites", "Cart", "Menu", "Search", "Profile"][currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.redAccent,
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => currentIndex = i),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_outlined),
                if (cartCount > 0)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.redAccent,
                      child: Text(
                        "$cartCount",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            label: "Cart",
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
