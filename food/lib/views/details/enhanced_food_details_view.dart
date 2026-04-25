import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/food_details_controller.dart';
import '../../core/state/view_state.dart';
import '../../models/food_model.dart';
import '../../models/review_model.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../utils/currency_formatter.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/loading_shimmer.dart';
import '../../widgets/quantity_stepper.dart';

class EnhancedFoodDetailsView extends GetView<FoodDetailsController> {
  const EnhancedFoodDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final food = controller.food.value;
      final state = controller.state.value;

      return Scaffold(
        extendBody: true,
        bottomNavigationBar: state == ViewState.success && food != null
            ? _BottomActions(controller: controller)
            : null,
        body: SafeArea(
          top: false,
          child: switch (state) {
            ViewState.loading => const Padding(
              padding: EdgeInsets.all(20),
              child: LoadingShimmer(height: 560, radius: 32),
            ),
            ViewState.error => EmptyState(
              icon: Icons.error_outline_rounded,
              title: 'Meal not available',
              message: controller.errorMessage.value,
              actionLabel: 'home'.tr,
              onAction: () => Get.back<void>(),
            ),
            _ when food != null => _DetailsContent(
              food: food,
              controller: controller,
            ),
            _ => EmptyState(
              icon: Icons.no_food_rounded,
              title: 'no_meals_here'.tr,
              message: 'no_meals_message'.tr,
            ),
          },
        ),
      );
    });
  }
}

class _DetailsContent extends StatelessWidget {
  const _DetailsContent({required this.food, required this.controller});

  final FoodModel food;
  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _HeroStage(food: food, controller: controller),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -22),
            child: _DetailsPanel(food: food, controller: controller),
          ),
        ),
      ],
    );
  }
}

class _HeroStage extends StatelessWidget {
  const _HeroStage({required this.food, required this.controller});

  final FoodModel food;
  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;

    return SizedBox(
      height: 444,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  AppColors.primary.withValues(alpha: .92),
                  AppColors.butter.withValues(alpha: .72),
                  AppColors.cream,
                ],
                stops: const <double>[0, .52, 1],
              ),
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(.05, -.08),
                  radius: .74,
                  colors: <Color>[
                    Colors.white.withValues(alpha: .64),
                    Colors.white.withValues(alpha: .18),
                    Colors.transparent,
                  ],
                  stops: const <double>[0, .42, 1],
                ),
              ),
            ),
          ),
          const _HeroIngredient(
            icon: Icons.eco_rounded,
            top: 116,
            left: 32,
            color: AppColors.leaf,
            delay: 0,
          ),
          const _HeroIngredient(
            icon: Icons.grain_rounded,
            top: 172,
            right: 30,
            color: AppColors.butter,
            delay: 130,
          ),
          const _HeroIngredient(
            icon: Icons.spa_rounded,
            bottom: 82,
            left: 42,
            color: AppColors.mint,
            delay: 260,
          ),
          Positioned(
            top: top + 12,
            left: 16,
            child: _GlassButton(
              icon: Icons.arrow_back_rounded,
              onTap: Get.back,
            ),
          ),
          Positioned(
            top: top + 12,
            right: 16,
            child: Obx(
              () => _GlassButton(
                icon: controller.isFavorite
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: controller.isFavorite ? AppColors.tomato : Colors.white,
                onTap: controller.toggleFavorite,
              ),
            ),
          ),
          Positioned(
            left: 18,
            right: 18,
            top: top + 84,
            child: _FloatingHeroImage(food: food),
          ),
        ],
      ),
    );
  }
}

class _FloatingHeroImage extends StatefulWidget {
  const _FloatingHeroImage({required this.food});

  final FoodModel food;

  @override
  State<_FloatingHeroImage> createState() => _FloatingHeroImageState();
}

class _FloatingHeroImageState extends State<_FloatingHeroImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final value = Curves.easeInOut.transform(_controller.value);
        final scale = .982 + (value * .026);

        return Transform.translate(
          offset: Offset(0, -16 * value),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0018)
              ..rotateX(-.055 + (value * .028))
              ..rotateY(.075 - (value * .045))
              ..rotateZ(math.sin(value * math.pi) * .018)
              ..multiply(Matrix4.diagonal3Values(scale, scale, scale)),
            child: child,
          ),
        );
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 760),
        curve: Curves.easeOutBack,
        builder: (context, value, child) {
          return Opacity(
            opacity: value.clamp(0, 1).toDouble(),
            child: Transform.scale(scale: .86 + (.14 * value), child: child),
          );
        },
        child: SizedBox(
          height: 300,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                bottom: 18,
                child: Container(
                  width: 210,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: .17),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .12),
                        blurRadius: 26,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                width: 285,
                height: 285,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.white.withValues(alpha: .54),
                        blurRadius: 74,
                        spreadRadius: 16,
                      ),
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: .22),
                        blurRadius: 70,
                        spreadRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Hero(
                tag: 'food-${widget.food.id}',
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 270,
                    height: 270,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(56),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: .92),
                        width: 8,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: AppColors.primaryDark.withValues(alpha: .26),
                          blurRadius: 46,
                          offset: const Offset(0, 26),
                        ),
                        BoxShadow(
                          color: Colors.white.withValues(alpha: .42),
                          blurRadius: 24,
                          offset: const Offset(-10, -12),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(46),
                      child: CachedNetworkImage(
                        imageUrl: widget.food.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: colorScheme.surfaceContainerHighest,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.fastfood_rounded, size: 56),
                        ),
                      ),
                    ),
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

class _DetailsPanel extends StatelessWidget {
  const _DetailsPanel({required this.food, required this.controller});

  final FoodModel food;
  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 154),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(38)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 30,
            offset: const Offset(0, -16),
          ),
        ],
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 560),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 24 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _TitlePriceCard(food: food),
            const SizedBox(height: 18),
            _QuickStats(food: food),
            const SizedBox(height: 26),
            _SectionTitle(title: 'description'.tr),
            const SizedBox(height: 10),
            Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.62,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 26),
            _ChipSection(
              title: 'ingredients'.tr,
              values: food.ingredients,
              icon: Icons.check_circle_rounded,
            ),
            const SizedBox(height: 26),
            if (food.sizes.isNotEmpty) _SizeSelector(controller: controller),
            if (food.sizes.isNotEmpty) const SizedBox(height: 24),
            if (food.extras.isNotEmpty) _ExtrasSelector(controller: controller),
            if (food.extras.isNotEmpty) const SizedBox(height: 24),
            _QuantityBlock(controller: controller),
            const SizedBox(height: 24),
            _RatingInput(controller: controller),
            const SizedBox(height: 24),
            _Reviews(reviews: food.reviews),
            if (food.reviews.isNotEmpty) const SizedBox(height: 12),
            _RecommendedSection(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _TitlePriceCard extends StatelessWidget {
  const _TitlePriceCard({required this.food});

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? colorScheme.onSurface : AppColors.charcoal;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : const Color(0xFFFFFBF3),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? colorScheme.outlineVariant
              : Colors.white.withValues(alpha: .86),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: .10),
            blurRadius: 30,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: Colors.white.withValues(alpha: isDark ? 0 : .62),
            blurRadius: 18,
            offset: const Offset(-8, -8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  food.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: titleColor,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                    letterSpacing: 0,
                  ),
                ),
                const SizedBox(height: 9),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.butter,
                      size: 19,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${food.rating.toStringAsFixed(1)}  (${food.reviewsCount})',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (food.oldPrice > food.price)
                Text(
                  CurrencyFormatter.format(food.oldPrice),
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  CurrencyFormatter.format(food.price),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.tomato,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickStats extends StatelessWidget {
  const _QuickStats({required this.food});

  final FoodModel food;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _StatCard(
            icon: Icons.star_rounded,
            label: 'rating'.tr,
            value: food.rating.toStringAsFixed(1),
            color: AppColors.butter,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.schedule_rounded,
            label: 'ready_in'.tr,
            value: food.preparationTime,
            color: AppColors.mint,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.local_fire_department_rounded,
            label: 'calories'.tr,
            value: '${food.calories}',
            color: AppColors.tomato,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 108,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: .96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: .62),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .045),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .14),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChipSection extends StatelessWidget {
  const _ChipSection({
    required this.title,
    required this.values,
    required this.icon,
  });

  final String title;
  final List<String> values;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    if (values.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: title),
        const SizedBox(height: 12),
        SizedBox(
          height: 46,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: values.length,
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              return _IngredientChip(icon: icon, label: values[index]);
            },
          ),
        ),
      ],
    );
  }
}

class _IngredientChip extends StatelessWidget {
  const _IngredientChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(maxWidth: 190),
      padding: const EdgeInsetsDirectional.only(start: 10, end: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.primary.withValues(alpha: .12)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: .10),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: AppColors.primary),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeSelector extends StatelessWidget {
  const _SizeSelector({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final food = controller.food.value;
    if (food == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: 'choose_size'.tr),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: food.sizes.map((size) {
              final selected = controller.selectedSize.value == size;
              return ChoiceChip(
                selected: selected,
                label: Text(size),
                onSelected: (_) => controller.selectSize(size),
                selectedColor: AppColors.primary.withValues(alpha: .18),
                side: BorderSide(
                  color: selected
                      ? AppColors.primary.withValues(alpha: .36)
                      : Theme.of(context).colorScheme.outlineVariant,
                ),
                labelStyle: TextStyle(
                  color: selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w800,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _ExtrasSelector extends StatelessWidget {
  const _ExtrasSelector({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final food = controller.food.value;
    if (food == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: 'extras'.tr),
        const SizedBox(height: 12),
        Obx(
          () => Wrap(
            spacing: 10,
            runSpacing: 10,
            children: food.extras.map((extra) {
              final selected = controller.selectedExtras.contains(extra);
              return FilterChip(
                selected: selected,
                label: Text(extra),
                avatar: Icon(selected ? Icons.done_rounded : Icons.add_rounded),
                onSelected: (_) => controller.toggleExtra(extra),
                selectedColor: AppColors.mint.withValues(alpha: .16),
                side: BorderSide(
                  color: selected
                      ? AppColors.mint.withValues(alpha: .34)
                      : Theme.of(context).colorScheme.outlineVariant,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _QuantityBlock extends StatelessWidget {
  const _QuantityBlock({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              'quantity'.tr,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
          ),
          Obx(
            () => QuantityStepper(
              quantity: controller.quantity.value,
              onIncrement: controller.incrementQuantity,
              onDecrement: controller.decrementQuantity,
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingInput extends StatelessWidget {
  const _RatingInput({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(title: 'rate_this_food'.tr),
          const SizedBox(height: 12),
          Obx(
            () => RatingBar.builder(
              initialRating: controller.userRating.value,
              minRating: 1,
              allowHalfRating: true,
              itemSize: 32,
              itemPadding: const EdgeInsetsDirectional.only(end: 4),
              unratedColor: colorScheme.outlineVariant,
              itemBuilder: (context, index) =>
                  const Icon(Icons.star_rounded, color: AppColors.butter),
              onRatingUpdate: controller.setRating,
            ),
          ),
        ],
      ),
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({required this.reviews});

  final List<ReviewModel> reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: 'reviews'.tr),
        const SizedBox(height: 12),
        ...reviews.map((review) => _ReviewTile(review: review)),
      ],
    );
  }
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .035),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: review.avatarUrl.isEmpty
                ? null
                : NetworkImage(review.avatarUrl),
            child: review.avatarUrl.isEmpty
                ? Text(review.userName.isEmpty ? '?' : review.userName[0])
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        review.userName,
                        style: const TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                    const Icon(
                      Icons.star_rounded,
                      color: AppColors.butter,
                      size: 18,
                    ),
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  review.comment,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedSection extends StatelessWidget {
  const _RecommendedSection({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.recommendations.toList();
      if (items.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SectionTitle(title: 'recommended_food_drinks'.tr),
          const SizedBox(height: 14),
          SizedBox(
            height: 208,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return _RecommendedFoodCard(food: items[index], index: index);
              },
            ),
          ),
        ],
      );
    });
  }
}

class _RecommendedFoodCard extends StatelessWidget {
  const _RecommendedFoodCard({required this.food, required this.index});

  final FoodModel food;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 460 + (index * 55)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(24 * (1 - value), 0),
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: () => Get.offNamed(AppRoutes.details, arguments: food),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          width: 154,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colorScheme.outlineVariant),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: .05),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl: food.imageUrl,
                  width: double.infinity,
                  height: 104,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: colorScheme.surfaceContainerHighest),
                  errorWidget: (context, url, error) => Container(
                    color: colorScheme.surfaceContainerHighest,
                    child: const Icon(Icons.fastfood_rounded),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                food.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.12,
                ),
              ),
              const Spacer(),
              Text(
                CurrencyFormatter.format(food.price),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(18, 14, 18, bottom + 14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withValues(alpha: .97),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .12),
            blurRadius: 30,
            offset: const Offset(0, -14),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _OutlineActionButton(
              icon: Icons.add_shopping_cart_rounded,
              label: 'add_to_cart'.tr,
              onTap: controller.addToCart,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
              () => _GradientActionButton(
                icon: Icons.flash_on_rounded,
                label:
                    '${'order_now'.tr}  ${CurrencyFormatter.format(controller.totalPrice)}',
                onTap: controller.orderNow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          height: 62,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: .55),
              width: 1.35,
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: .08),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: colorScheme.primary, size: 21),
              const SizedBox(width: 8),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    maxLines: 1,
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w900,
                    ),
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

class _GradientActionButton extends StatelessWidget {
  const _GradientActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[AppColors.primary, AppColors.tomato],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: .25),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: SizedBox(
            height: 62,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(icon, color: Colors.white, size: 21),
                  const SizedBox(width: 8),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        label,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
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

class _HeroIngredient extends StatelessWidget {
  const _HeroIngredient({
    required this.icon,
    required this.color,
    required this.delay,
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final IconData icon;
  final Color color;
  final int delay;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: Duration(milliseconds: 720 + delay),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, 18 * (1 - value)),
              child: child,
            ),
          );
        },
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: .24),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withValues(alpha: .34)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: .12),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 22),
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({
    required this.icon,
    required this.onTap,
    this.color = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: .20),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 48, height: 48, child: Icon(icon, color: color)),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 0,
      ),
    );
  }
}
