import 'package:flutter/material.dart';
import 'package:food/data/api_model.dart';
import 'package:food/pages/home/widget/product_card.dart';
import 'package:food/pages/product_details/product_details_page.dart';

class ProductsList extends StatelessWidget {
  final List<ApiModel> recipes;
  final Set<int> favorites;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Function(ApiModel) onCartAdded;
  final Function(int) toggleFavorite;

  const ProductsList({
    super.key,
    required this.recipes,
    required this.favorites,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.onCartAdded,
    required this.toggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: recipes.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProductDetailsPage(recipe: recipes[index]),
              ),
            ),
            child: ProductCard(
              recipe: recipes[index],
              index: index,
              favorites: favorites,
              addToCart: onCartAdded,
              toggleFavorite: toggleFavorite,
            ),
          ),
        ),
      ),
    );
  }
}
