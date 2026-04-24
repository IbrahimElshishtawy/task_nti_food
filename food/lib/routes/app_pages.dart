import 'package:get/get.dart';

import '../bindings/details_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/order_binding.dart';
import '../bindings/search_binding.dart';
import '../views/cart/cart_view.dart';
import '../views/checkout/confirm_order_view.dart';
import '../views/checkout/payment_methods_view.dart';
import '../views/details/food_details_view.dart';
import '../views/favorites/favorites_view.dart';
import '../views/home/home_view.dart';
import '../views/orders/order_history_view.dart';
import '../views/search/search_view.dart';
import '../views/settings/settings_view.dart';
import 'app_routes.dart';

class AppPages {
  const AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<dynamic>(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
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
      page: () => const FoodDetailsView(),
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
      name: AppRoutes.settings,
      page: () => const SettingsView(),
      transition: Transition.fadeIn,
    ),
  ];
}
