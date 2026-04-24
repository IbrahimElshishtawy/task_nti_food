import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/favorites_controller.dart';
import '../../controllers/home_controller.dart';
import '../../core/constants/app_constants.dart';
import '../../core/state/view_state.dart';
import '../../models/ad_model.dart';
import '../../models/category_model.dart';
import '../../models/food_model.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/app_bottom_nav.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/food_3d_card.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/premium_search_bar.dart';
import '../../widgets/section_header.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const AppBottomNav(currentIndex: 0),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.loadHomeData,
          child: CustomScrollView(
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
                        onTap: () => Get.toNamed(AppRoutes.search),
                      ),
                      const SizedBox(height: 14),
                      const _SuggestionChips(),
                      const SizedBox(height: 24),
                      Obx(() => _AdCarousel(controller: controller)),
                      const SizedBox(height: 26),
                      const SectionHeader(title: 'Explore categories'),
                      const SizedBox(height: 12),
                      Obx(() => _CategoryStrip(controller: controller)),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Popular near you',
                        actionLabel: 'Search',
                        onAction: () => Get.toNamed(AppRoutes.search),
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
              Obx(() => _FoodGrid(controller: controller)),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
                'Good morning, ${AppConstants.defaultUserName}',
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
                      'Deliver to ${AppConstants.defaultDeliveryLocation}',
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
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: .06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Badge(
            smallSize: 9,
            child: Icon(Icons.notifications_none_rounded),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: AppConstants.searchChips.map((chip) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ActionChip(
              label: Text(chip),
              avatar: const Icon(Icons.local_fire_department_rounded, size: 18),
              onPressed: () => Get.toNamed(AppRoutes.search, arguments: chip),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AdCarousel extends StatelessWidget {
  const _AdCarousel({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.state.value == ViewState.loading && controller.ads.isEmpty) {
      return const LoadingShimmer(height: 190, radius: 28);
    }

    if (controller.ads.isEmpty) return const SizedBox.shrink();

    return Column(
      children: <Widget>[
        CarouselSlider.builder(
          itemCount: controller.ads.length,
          itemBuilder: (context, index, realIndex) {
            return _AdCard(ad: controller.ads[index]);
          },
          options: CarouselOptions(
            height: 190,
            viewportFraction: .88,
            enlargeCenterPage: true,
            enlargeFactor: .18,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            onPageChanged: (index, reason) => controller.changeAd(index),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(controller.ads.length, (index) {
            final active = controller.currentAdIndex.value == index;
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
            padding: const EdgeInsets.all(20),
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
  const _CategoryStrip({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.state.value == ViewState.loading &&
        controller.categories.isEmpty) {
      return const LoadingShimmer(height: 76, radius: 24);
    }

    final categories = <CategoryModel>[
      const CategoryModel(
        id: 'all',
        name: 'All',
        imageUrl: '',
        colorHex: 'FFFFFF',
      ),
      ...controller.categories,
    ];

    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final category = categories[index];
          final selected = controller.selectedCategoryId.value == category.id;
          return _CategoryPill(
            category: category,
            selected: selected,
            onTap: () => controller.selectCategory(category.id),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: categories.length,
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
  const _FoodGrid({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    final state = controller.state.value;
    if (state == ViewState.loading && controller.foods.isEmpty) {
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
          title: 'Could not load menu',
          message: controller.errorMessage.value,
          actionLabel: 'Try again',
          onAction: controller.loadHomeData,
        ),
      );
    }

    final foods = controller.filteredFoods;
    if (foods.isEmpty) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyState(
          icon: Icons.no_food_rounded,
          title: 'No meals here yet',
          message: 'Try another category or search for your favorite meal.',
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
              return Food3DCard(
                food: food,
                isFavorite: favoritesController.isFavorite(food.id),
                onFavorite: () => controller.toggleFavorite(food),
                onCart: () => controller.addToCart(food),
              );
            },
          );
        },
      ),
    );
  }
}
