import 'package:get/get.dart';

import '../controllers/food_search_controller.dart';
import '../data/repositories/food_repository.dart';
import '../services/storage_service.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<FoodSearchController>()) {
      Get.lazyPut<FoodSearchController>(
        () => FoodSearchController(
          Get.find<FoodRepository>(),
          Get.find<StorageService>(),
        ),
        fenix: true,
      );
    }
  }
}
