import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/home/widget/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;

  int cartCount = 0;
  int currentIndex = 0;
  final Set<int> favorites = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final data = await apiClient.fetchRecipes();
      setState(() {
        recipes = data.map((json) => ApiModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error fetching recipes: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void addToCart(ApiModel recipe) {
    setState(() {
      cartCount++;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${recipe.name} added to cart")));
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

  void goToCategories() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const CategoriesPage()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  recipe: recipes[index],
                  index: index,
                  favorites: favorites,
                  addToCart: addToCart,
                  toggleFavorite: toggleFavorite,
                );
              },
            ),
      // const FavoritesPage(),
      //const SearchPage(),
      //const ProfilePage(),
    ];

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: goToCategories,
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              if (cartCount > 0)
                Positioned(
                  right: 6,
                  top: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Text(
                      "$cartCount",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
