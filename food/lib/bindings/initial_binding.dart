import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/payment_controller.dart';
import '../controllers/settings_controller.dart';
import '../data/repositories/food_repository.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ApiService>(ApiService(), permanent: true);
    Get.put<FoodRepository>(
      FoodRepository(Get.find<ApiService>()),
      permanent: true,
    );
    Get.put<FavoritesController>(
      FavoritesController(Get.find<StorageService>()),
      permanent: true,
    );
    Get.put<CartController>(
      CartController(Get.find<StorageService>()),
      permanent: true,
    );
    Get.put<PaymentController>(
      PaymentController(Get.find<StorageService>()),
      permanent: true,
    );
    Get.put<SettingsController>(
      SettingsController(Get.find<StorageService>()),
      permanent: true,
    );
  }
}
