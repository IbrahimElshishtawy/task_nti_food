// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/product_details/widget/details_section.dart';

class SuggestedCard extends StatelessWidget {
  final ApiModel recipe;
  final int id;
  final String imageUrl;
  final String title;

  const SuggestedCard({
    super.key,
    required this.recipe,
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsSection(recipe: recipe),
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // الصورة
              Image.network(
                imageUrl,
                height: 160,
                width: 160,
                fit: BoxFit.cover,
              ),
              // جريدينت عشان النص يبان
              Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.1),
                      Colors.black.withOpacity(0.6),
                    ],
                  ),
                ),
              ),
              // النصوص
              Positioned(
                bottom: 10,
                left: 8,
                right: 8,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black54,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
