import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';
import '../theme/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.visible,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final items = <_NavItem>[
      _NavItem(Icons.home_outlined, Icons.home_rounded, 'home'.tr),
      _NavItem(Icons.search_rounded, Icons.travel_explore_rounded, 'search'.tr),
      _NavItem(
        Icons.favorite_border_rounded,
        Icons.favorite_rounded,
        'favorites'.tr,
      ),
      _NavItem(
        Icons.receipt_long_outlined,
        Icons.receipt_long_rounded,
        'orders'.tr,
      ),
      _NavItem(
        Icons.notifications_none_rounded,
        Icons.notifications_rounded,
        'notifications'.tr,
      ),
      _NavItem(Icons.settings_outlined, Icons.settings_rounded, 'settings'.tr),
    ];

    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        offset: visible ? Offset.zero : const Offset(0, 1.35),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.fromLTRB(
            14,
            10,
            14,
            MediaQuery.paddingOf(context).bottom + 12,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colorScheme.surface.withValues(alpha: .94),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: .55),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: AppColors.primaryDark.withValues(alpha: .16),
                  blurRadius: 34,
                  offset: const Offset(0, 18),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: .05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                height: 68,
                child: Row(
                  children: List<Widget>.generate(items.length, (index) {
                    return Expanded(
                      child: _BottomNavTile(
                        item: items[index],
                        active: currentIndex == index,
                        onTap: () => onTap(index),
                        showBadge: index == 4,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavTile extends StatelessWidget {
  const _BottomNavTile({
    required this.item,
    required this.active,
    required this.onTap,
    required this.showBadge,
  });

  final _NavItem item;
  final bool active;
  final VoidCallback onTap;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
            decoration: BoxDecoration(
              gradient: active
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[AppColors.primary, AppColors.butter],
                    )
                  : null,
              color: active ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedScale(
                  scale: active ? 1.08 : 1,
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutBack,
                  child: _BadgeIcon(
                    icon: active ? item.activeIcon : item.icon,
                    active: active,
                    showBadge: showBadge,
                  ),
                ),
                const SizedBox(height: 4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.label,
                    maxLines: 1,
                    style: TextStyle(
                      color: active
                          ? Colors.white
                          : colorScheme.onSurfaceVariant,
                      fontSize: 10.5,
                      fontWeight: active ? FontWeight.w900 : FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BadgeIcon extends StatelessWidget {
  const _BadgeIcon({
    required this.icon,
    required this.active,
    required this.showBadge,
  });

  final IconData icon;
  final bool active;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    final iconWidget = Icon(
      icon,
      size: 22,
      color: active ? Colors.white : Theme.of(context).colorScheme.onSurface,
    );

    if (!showBadge || !Get.isRegistered<NotificationsController>()) {
      return iconWidget;
    }

    return Obx(() {
      final count = Get.find<NotificationsController>().unreadCount;
      return Badge(
        isLabelVisible: count > 0,
        label: Text('$count'),
        child: iconWidget,
      );
    });
  }
}

class _NavItem {
  const _NavItem(this.icon, this.activeIcon, this.label);

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
