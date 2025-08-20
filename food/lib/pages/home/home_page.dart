import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/home/widget/recipe_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Row الأزرار مع إمكانية التمرير
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildButton(Icons.restaurant_menu, "Menu"),
                const SizedBox(width: 12),
                _buildButton(Icons.favorite, "Favorites"),
                const SizedBox(width: 12),
                _buildButton(Icons.shopping_cart, "Orders"),
                const SizedBox(width: 12),
                _buildButton(Icons.person, "Profile"),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // عرض الوصفات
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.8,
                        ),
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return BounceIn(
                        duration: Duration(milliseconds: 500 + (index * 100)),
                        child: RecipeCard(recipe: recipe),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.redAccent),
      label: Text(label, style: const TextStyle(color: Colors.redAccent)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 4,
      ),
    );
  }
}
