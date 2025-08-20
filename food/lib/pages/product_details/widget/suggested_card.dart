import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';

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
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 100,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
