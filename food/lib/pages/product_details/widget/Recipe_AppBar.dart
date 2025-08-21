// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../data/api_model.dart';

class RecipeAppBar extends StatelessWidget {
  final ApiModel recipe;
  final Animation<double> fadeIn;

  const RecipeAppBar({super.key, required this.recipe, required this.fadeIn});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color.fromARGB(255, 245, 244, 244),
        ),
        onPressed: () => Navigator.pop(context),
      ),

      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12, top: 6),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 138, 136, 136).withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Added to favorites ❤️")),
              );
            },
          ),
        ),
      ],

      flexibleSpace: FlexibleSpaceBar(
        // 🔥 تعديل هنا علشان العنوان يبقى من الشمال
        centerTitle: false,
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            recipe.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              shadows: [
                Shadow(
                  blurRadius: 6,
                  color: Colors.black54,
                  offset: Offset(1, 1),
                ),
              ],
            ),
          ),
        ),
        background: Hero(
          tag: "recipe_${recipe.id}",
          child: FadeTransition(
            opacity: fadeIn,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  recipe.image.isNotEmpty
                      ? Image.network(recipe.image, fit: BoxFit.cover)
                      : Image.asset(
                          "assets/images/placeholder.png",
                          fit: BoxFit.cover,
                        ),
                  // 🔥 تدرج لوني أسود من تحت لفوق
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.2),
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
    );
  }
}
