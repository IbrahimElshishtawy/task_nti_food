import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../controllers/food_details_controller.dart';
import '../../core/state/view_state.dart';
import '../../models/food_model.dart';
import '../../models/review_model.dart';
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
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: _HeroStage(food: food, controller: controller),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -34),
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
    return SizedBox(
      height: 430,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  AppColors.cream,
                  AppColors.butter.withValues(alpha: .78),
                  AppColors.primary.withValues(alpha: .92),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            left: 16,
            child: _GlassButton(
              icon: Icons.arrow_back_rounded,
              onTap: Get.back,
            ),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
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
            top: MediaQuery.paddingOf(context).top + 84,
            child: _FloatingHeroImage(food: food),
          ),
          Positioned(
            left: 22,
            right: 22,
            bottom: 44,
            child: Row(
              children: <Widget>[
                _HeroPill(
                  icon: Icons.star_rounded,
                  label: food.rating.toStringAsFixed(1),
                  color: AppColors.butter,
                ),
                const SizedBox(width: 10),
                _HeroPill(
                  icon: Icons.schedule_rounded,
                  label: food.preparationTime,
                  color: AppColors.mint,
                ),
                const Spacer(),
                _HeroPill(
                  icon: Icons.local_fire_department_rounded,
                  label: '${food.calories}',
                  color: AppColors.tomato,
                ),
              ],
            ),
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
        return Transform.translate(
          offset: Offset(0, -14 * value),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0018)
              ..rotateX(-.05 + (value * .025))
              ..rotateY(.06 - (value * .035))
              ..rotateZ(math.sin(value * math.pi) * .018)
              ..scale(.98 + (value * .025)),
            child: child,
          ),
        );
      },
      child: SizedBox(
        height: 264,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 10,
              child: Container(
                width: 210,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .18),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            Hero(
              tag: 'food-${widget.food.id}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 252,
                  height: 252,
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(52),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.primaryDark.withValues(alpha: .24),
                        blurRadius: 42,
                        offset: const Offset(0, 24),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(44),
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
      padding: const EdgeInsets.fromLTRB(20, 26, 20, 132),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .08),
            blurRadius: 28,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    food.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.08,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    if (food.oldPrice > food.price)
                      Text(
                        CurrencyFormatter.format(food.oldPrice),
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          decoration: TextDecoration.lineThrough,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    Text(
                      CurrencyFormatter.format(food.price),
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            _QuickStats(food: food),
            const SizedBox(height: 24),
            _SectionTitle(title: 'description'.tr),
            const SizedBox(height: 10),
            Text(
              food.description,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.58,
              ),
            ),
            const SizedBox(height: 24),
            _ChipSection(
              title: 'ingredients'.tr,
              values: food.ingredients,
              icon: Icons.check_circle_rounded,
            ),
            const SizedBox(height: 24),
            if (food.sizes.isNotEmpty) _SizeSelector(controller: controller),
            if (food.sizes.isNotEmpty) const SizedBox(height: 24),
            if (food.extras.isNotEmpty) _ExtrasSelector(controller: controller),
            if (food.extras.isNotEmpty) const SizedBox(height: 24),
            _QuantityBlock(controller: controller),
            const SizedBox(height: 24),
            _RatingInput(controller: controller),
            const SizedBox(height: 24),
            _Reviews(reviews: food.reviews),
          ],
        ),
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
            value: '${food.rating.toStringAsFixed(1)} (${food.reviewsCount})',
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
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Icon(icon, color: color),
          const SizedBox(height: 7),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 11,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _SectionTitle(title: title),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: values.map((value) {
            return Chip(
              avatar: Icon(icon, size: 18),
              label: Text(value),
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            );
          }).toList(),
        ),
      ],
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
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.outlineVariant),
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
            () => AnimatedScale(
              scale: 1,
              duration: const Duration(milliseconds: 180),
              child: QuantityStepper(
                quantity: controller.quantity.value,
                onIncrement: controller.incrementQuantity,
                onDecrement: controller.decrementQuantity,
              ),
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
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
              unratedColor: Theme.of(context).colorScheme.outlineVariant,
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
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: colorScheme.outlineVariant),
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

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.controller});

  final FoodDetailsController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.fromLTRB(
        18,
        12,
        18,
        MediaQuery.paddingOf(context).bottom + 12,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface.withValues(alpha: .96),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .10),
            blurRadius: 28,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: OutlinedButton.icon(
              onPressed: controller.addToCart,
              icon: const Icon(Icons.add_shopping_cart_rounded),
              label: Text('add_to_cart'.tr),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Obx(
              () => FilledButton.icon(
                onPressed: controller.orderNow,
                icon: const Icon(Icons.flash_on_rounded),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${'order_now'.tr}  ${CurrencyFormatter.format(controller.totalPrice)}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .24),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: .30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
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
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
    );
  }
}
