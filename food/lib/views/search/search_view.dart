import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/favorites_controller.dart';
import '../../controllers/food_search_controller.dart';
import '../../core/state/view_state.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/food_list_card.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/premium_search_bar.dart';

class SearchView extends GetView<FoodSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesController = Get.find<FavoritesController>();
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PremiumSearchBar(
                controller: controller.textController,
                autofocus: true,
                onChanged: controller.onQueryChanged,
                hintText: 'Pizza, Burger, Pasta...',
              ),
              const SizedBox(height: 14),
              Obx(() => _SuggestionRow(controller: controller)),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  switch (controller.state.value) {
                    case ViewState.idle:
                      return const EmptyState(
                        icon: Icons.search_rounded,
                        title: 'What are you craving?',
                        message: 'Start typing or tap a suggestion above.',
                      );
                    case ViewState.loading:
                      return ListView.separated(
                        itemCount: 5,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) =>
                            const LoadingShimmer(height: 118),
                      );
                    case ViewState.empty:
                      return const EmptyState(
                        icon: Icons.manage_search_rounded,
                        title: 'No results found',
                        message: 'Try a different meal name or category.',
                      );
                    case ViewState.error:
                      return EmptyState(
                        icon: Icons.error_outline_rounded,
                        title: 'Search failed',
                        message: controller.errorMessage.value,
                      );
                    case ViewState.success:
                      return ListView.separated(
                        padding: const EdgeInsets.only(bottom: 24),
                        itemCount: controller.results.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final food = controller.results[index];
                          return Obx(
                            () => FoodListCard(
                              food: food,
                              isFavorite: favoritesController.isFavorite(
                                food.id,
                              ),
                              onFavorite: () =>
                                  favoritesController.toggleFavorite(food),
                              onCart: () => cartController.addItem(food),
                            ),
                          );
                        },
                      );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.controller});

  final FoodSearchController controller;

  @override
  Widget build(BuildContext context) {
    final suggestions = controller.suggestions;
    if (suggestions.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: suggestions.map((suggestion) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InputChip(
              label: Text(suggestion),
              avatar: const Icon(Icons.bolt_rounded, size: 18),
              onPressed: () => controller.useSuggestion(suggestion),
            ),
          );
        }).toList(),
      ),
    );
  }
}
