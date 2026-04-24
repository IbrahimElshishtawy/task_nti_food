import 'package:get/get.dart';

import '../bindings/details_binding.dart';
import '../bindings/order_binding.dart';
import '../bindings/search_binding.dart';
import '../controllers/notifications_controller.dart';
import '../controllers/splash_controller.dart';
import '../data/repositories/food_repository.dart';
import '../views/cart/cart_view.dart';
import '../views/checkout/confirm_order_view.dart';
import '../views/checkout/payment_methods_view.dart';
import '../views/details/enhanced_food_details_view.dart';
import '../views/favorites/favorites_view.dart';
import '../views/main_navigation/main_navigation_view.dart';
import '../views/notifications/notifications_view.dart';
import '../views/orders/order_history_view.dart';
import '../views/search/search_view.dart';
import '../views/settings/settings_view.dart';
import '../views/splash/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  const AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SplashController>(() => SplashController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const MainNavigationView(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.mainNavigation,
      page: () => const MainNavigationView(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
      transition: Transition.downToUp,
    ),
    GetPage<dynamic>(
      name: AppRoutes.details,
      page: () => const EnhancedFoodDetailsView(),
      binding: DetailsBinding(),
      transition: Transition.cupertino,
    ),
    GetPage<dynamic>(
      name: AppRoutes.favorites,
      page: () => const FavoritesView(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.cart,
      page: () => const CartView(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: AppRoutes.checkout,
      page: () => const ConfirmOrderView(),
      binding: OrderBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodsView(),
      transition: Transition.rightToLeft,
    ),
    GetPage<dynamic>(
      name: AppRoutes.orders,
      page: () => const OrderHistoryView(),
      binding: OrderBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.notifications,
      page: () => const NotificationsView(),
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<NotificationsController>()) {
          Get.lazyPut<NotificationsController>(
            () => NotificationsController(Get.find<FoodRepository>()),
            fenix: true,
          );
        }
      }),
      transition: Transition.fadeIn,
    ),
    GetPage<dynamic>(
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      transition: Transition.fadeIn,
    ),
  ];
}
