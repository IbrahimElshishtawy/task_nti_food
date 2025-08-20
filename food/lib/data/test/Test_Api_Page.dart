// ignore_for_file: file_names

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';

class TestApiPage extends StatefulWidget {
  const TestApiPage({super.key});

  @override
  State<TestApiPage> createState() => _TestApiPageState();
}

class _TestApiPageState extends State<TestApiPage> {
  final ApiClient apiClient = ApiClient();
  List<ApiModel> recipes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    try {
      final data = await apiClient.fetchRecipes();
      recipes = data.map((json) => ApiModel.fromJson(json)).toList();

      for (var recipe in recipes) {
        if (kDebugMode) {
          print("ID: ${recipe.id}");
          print("Name: ${recipe.name}");
          print("Recipe Description: ${recipe.description}");
          print("Ingredients: ${recipe.ingredients.join(', ')}");
          print("Instructions: ${recipe.instructions.join(' | ')}");
          print("Prep Time: ${recipe.prepTimeMinutes} mins");
          print("Cook Time: ${recipe.cookTimeMinutes} mins");
          print("Servings: ${recipe.servings}");
          print("Difficulty: ${recipe.difficulty}");
          print("Cuisine: ${recipe.cuisine}");
          print("Calories: ${recipe.caloriesPerServing}");
          print("Tags: ${recipe.tags.join(', ')}");
          print("User ID: ${recipe.userId}");
          print("Image: ${recipe.image}");
          print("Rating: ${recipe.rating}");
          print("Review Count: ${recipe.reviewCount}");
          print("Meal Type: ${recipe.mealType.join(', ')}");
          print("-------------------------------");
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching recipes: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test API Recipes")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return ListTile(
                  leading: Image.network(
                    recipe.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(recipe.name),
                  subtitle: Text("${recipe.cuisine} | ${recipe.difficulty}"),
                );
              },
            ),
    );
  }
}
