import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/Favorites_food/ui/Favorites_food_page.dart';
import 'package:food/pages/Search/Search_Page.dart';
import 'package:food/pages/home_products/ui/home_products_bage.dart';
import 'package:food/pages/cart/cart_page.dart';
import 'package:food/pages/setting/SettingsPage.dart'; // <-- تأكد من المسار الصحيح

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cartCount = 0;
  int currentIndex = 2; // البداية على الصفحة الرئيسية
  final Set<int> favorites = {};
  final List<ApiModel> recipes = []; // قائمة المنتجات
  final List<ApiModel> cartItems = []; // قائمة السلة

  void toggleFavorite(int index) {
    setState(() {
      favorites.contains(index)
          ? favorites.remove(index)
          : favorites.add(index);
    });
  }

  void addToCart(ApiModel recipe) {
    setState(() {
      // تحقق إذا المنتج موجود مسبقًا في السلة
      final existingIndex = cartItems.indexWhere(
        (item) => item.id == recipe.id,
      );
      if (existingIndex >= 0) {
        cartItems[existingIndex].quantity++;
      } else {
        cartItems.add(
          ApiModel(
            id: recipe.id,
            name: recipe.name,
            ingredients: recipe.ingredients,
            instructions: recipe.instructions,
            prepTimeMinutes: recipe.prepTimeMinutes,
            cookTimeMinutes: recipe.cookTimeMinutes,
            servings: recipe.servings,
            difficulty: recipe.difficulty,
            cuisine: recipe.cuisine,
            caloriesPerServing: recipe.caloriesPerServing,
            tags: recipe.tags,
            userId: recipe.userId,
            image: recipe.image,
            rating: recipe.rating,
            reviewCount: recipe.reviewCount,
            mealType: recipe.mealType,
            price: recipe.price,
            quantity: 1,
          ),
        );
      }
      cartCount = cartItems.length;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${recipe.name} added to cart")));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      FavoritesPage(
        favoriteRecipes: favorites
            .where((i) => i < recipes.length)
            .map((i) => recipes[i])
            .toList(),
        toggleFavorite: toggleFavorite,
        recipes: recipes,
        favorites: favorites,
      ),
      CartPage(cartItems: cartItems), // صفحة السلة الحقيقية
      HomeProductsPage(
        recipes: recipes,
        favoritesSet: favorites,
        toggleFavorite: toggleFavorite,
        onCartAdded: addToCart,
      ),
      SearchPage(recipes: recipes),
      const SettingsPage(),
    ];

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: Text(
          ["Favorites", "Cart", "Menu", "Search", "Settings"][currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.redAccent,
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
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
