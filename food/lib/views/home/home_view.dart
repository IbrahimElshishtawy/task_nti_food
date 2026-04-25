import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/favorites_controller.dart';
import '../../controllers/food_search_controller.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/navigation_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../core/state/view_state.dart';
import '../../models/ad_model.dart';
import '../../models/category_model.dart';
import '../../models/food_model.dart';
import '../../theme/app_colors.dart';
import '../../widgets/animated_3d_food_card.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/premium_search_bar.dart';
import '../../widgets/section_header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.find<NavigationController>();
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadHomeData,
          child: CustomScrollView(
            controller: navigationController.homeScrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const _HomeHeader(),
                      const SizedBox(height: 22),
                      PremiumSearchBar(
                        readOnly: true,
                        hintText: 'search_hint'.tr,
                        onTap: () => navigationController.changeTab(1),
                      ),
                      const SizedBox(height: 14),
                      const _SuggestionChips(),
                      const SizedBox(height: 24),
                      Obx(
                        () => _AdCarousel(
                          state: controller.state.value,
                          ads: controller.ads.toList(),
                          currentAdIndex: controller.currentAdIndex.value,
                          onPageChanged: controller.changeAd,
                        ),
                      ),
                      const SizedBox(height: 26),
                      SectionHeader(title: 'explore_categories'.tr),
                      const SizedBox(height: 12),
                      Obx(
                        () => _CategoryStrip(
                          state: controller.state.value,
                          sourceCategories: controller.categories.toList(),
                          selectedCategoryId:
                              controller.selectedCategoryId.value,
                          onSelected: controller.selectCategory,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'popular_near_you'.tr,
                        actionLabel: 'search'.tr,
                        onAction: () => navigationController.changeTab(1),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              Obx(
                () => _FoodGrid(
                  state: controller.state.value,
                  errorMessage: controller.errorMessage.value,
                  foods: controller.filteredFoods,
                  onRetry: controller.loadHomeData,
                  onFavorite: controller.toggleFavorite,
                  onCart: controller.addToCart,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 126)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'good_morning'.trParams(<String, String>{
                  'name': AppConstants.defaultUserName,
                }),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 7),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on_rounded,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      'deliver_to'.trParams(<String, String>{
                        'location': AppConstants.defaultDeliveryLocation,
                      }),
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Material(
          color: colorScheme.surface,
          shape: const CircleBorder(),
          elevation: 0,
          shadowColor: Colors.black.withValues(alpha: .08),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => Get.find<NavigationController>().changeTab(4),
            child: const SizedBox(
              width: 48,
              height: 48,
              child: Badge(
                smallSize: 9,
                child: Icon(Icons.notifications_none_rounded),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SuggestionChips extends StatelessWidget {
  const _SuggestionChips();

  @override
  Widget build(BuildContext context) {
    final chips = Get.locale?.languageCode == 'ar'
        ? const <String>['بيتزا', 'برجر', 'باستا', 'فراخ', 'حلويات']
        : AppConstants.searchChips;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: chips.map((chip) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ActionChip(
              label: Text(chip),
              avatar: const Icon(Icons.local_fire_department_rounded, size: 18),
              onPressed: () {
                Get.find<FoodSearchController>().useSuggestion(chip);
                Get.find<NavigationController>().changeTab(1);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AdCarousel extends StatelessWidget {
  const _AdCarousel({
    required this.state,
    required this.ads,
    required this.currentAdIndex,
    required this.onPageChanged,
  });

  final ViewState state;
  final List<AdModel> ads;
  final int currentAdIndex;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    if (state == ViewState.loading && ads.isEmpty) {
      return const LoadingShimmer(height: 190, radius: 28);
    }

    if (ads.isEmpty) return const SizedBox.shrink();

    return Column(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: ads.length,
          itemBuilder: (context, index, realIndex) {
            return _AdCard(ad: ads[index]);
          },
          options: CarouselOptions(
            height: 190,
            viewportFraction: .88,
            enlargeCenterPage: true,
            enlargeFactor: .18,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) => onPageChanged(index),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(ads.length, (index) {
            final active = currentAdIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: active ? 22 : 7,
              height: 7,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: active
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(999),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _AdCard extends StatelessWidget {
  const _AdCard({required this.ad});

  final AdModel ad;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: ad.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Icon(Icons.restaurant_rounded),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Colors.black.withValues(alpha: .72),
                  Colors.black.withValues(alpha: .18),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  ad.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  ad.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                FilledButton.tonalIcon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(ad.actionLabel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryStrip extends StatelessWidget {
  const _CategoryStrip({
    required this.state,
    required this.sourceCategories,
    required this.selectedCategoryId,
    required this.onSelected,
  });

  final ViewState state;
  final List<CategoryModel> sourceCategories;
  final String selectedCategoryId;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    if (state == ViewState.loading && sourceCategories.isEmpty) {
      return const LoadingShimmer(height: 76, radius: 24);
    }

    final visibleCategories = <CategoryModel>[
      CategoryModel(
        id: 'all',
        name: 'all'.tr,
        imageUrl: '',
        colorHex: 'FFFFFF',
      ),
      ...sourceCategories,
    ];

    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = visibleCategories[index];
          final selected = selectedCategoryId == category.id;
          return _CategoryPill(
            category: category,
            selected: selected,
            onTap: () => onSelected(category.id),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: visibleCategories.length,
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({
    required this.category,
    required this.selected,
    required this.onTap,
  });

  final CategoryModel category;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        width: 92,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: <BoxShadow>[
            if (selected)
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: .24),
                blurRadius: 22,
                offset: const Offset(0, 12),
              ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: selected
                    ? Colors.white.withValues(alpha: .18)
                    : AppColors.cream,
                shape: BoxShape.circle,
              ),
              child: category.imageUrl.isEmpty
                  ? Icon(
                      Icons.restaurant_menu_rounded,
                      color: selected ? Colors.white : colorScheme.primary,
                    )
                  : ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: category.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const Spacer(),
            Text(
              category.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? Colors.white : colorScheme.onSurface,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodGrid extends StatelessWidget {
  const _FoodGrid({
    required this.state,
    required this.errorMessage,
    required this.foods,
    required this.onRetry,
    required this.onFavorite,
    required this.onCart,
  });

  final ViewState state;
  final String errorMessage;
  final List<FoodModel> foods;
  final VoidCallback onRetry;
  final ValueChanged<FoodModel> onFavorite;
  final ValueChanged<FoodModel> onCart;

  @override
  Widget build(BuildContext context) {
    if (state == ViewState.loading && foods.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid.builder(
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: .64,
          ),
          itemBuilder: (context, index) => const LoadingShimmer(height: 260),
        ),
      );
    }

    if (state == ViewState.error) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          icon: Icons.wifi_off_rounded,
          title: 'could_not_load_menu'.tr,
          message: errorMessage,
          actionLabel: 'try_again'.tr,
          onAction: onRetry,
        ),
      );
    }

    if (foods.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          icon: Icons.no_food_rounded,
          title: 'no_meals_here'.tr,
          message: 'no_meals_message'.tr,
        ),
      );
    }

    final favoritesController = Get.find<FavoritesController>();
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverLayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.crossAxisExtent;
          final crossAxisCount = width >= 820
              ? 4
              : width >= 620
              ? 3
              : 2;
          return SliverGrid.builder(
            itemCount: foods.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: width >= 620 ? .72 : .62,
            ),
            itemBuilder: (context, index) {
              final FoodModel food = foods[index];
              return Obx(
                () => Animated3DFoodCard(
                  food: food,
                  index: index,
                  isFavorite: favoritesController.isFavorite(food.id),
                  onFavorite: () => onFavorite(food),
                  onCart: () => onCart(food),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
