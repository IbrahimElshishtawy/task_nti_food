import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/navigation_controller.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../favorites/favorites_view.dart';
import '../home/home_view.dart';
import '../notifications/notifications_view.dart';
import '../orders/order_history_view.dart';
import '../search/search_view.dart';
import '../settings/settings_view.dart';

class MainNavigationView extends GetView<NavigationController> {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.currentIndex.value;
      return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        body: NotificationListener<ScrollNotification>(
          onNotification: controller.handleScrollNotification,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: IndexedStack(
                  index: index,
                  children: <Widget>[
                    HeroMode(enabled: index == 0, child: const HomeView()),
                    HeroMode(enabled: index == 1, child: const SearchView()),
                    HeroMode(enabled: index == 2, child: const FavoritesView()),
                    HeroMode(
                      enabled: index == 3,
                      child: const OrderHistoryView(),
                    ),
                    HeroMode(
                      enabled: index == 4,
                      child: const NotificationsView(),
                    ),
                    HeroMode(enabled: index == 5, child: const SettingsView()),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CustomBottomNavBar(
                  currentIndex: index,
                  visible: controller.isNavVisible.value,
                  onTap: controller.changeTab,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
