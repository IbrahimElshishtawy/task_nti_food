import 'package:get/get.dart';

import '../controllers/food_search_controller.dart';
import '../data/repositories/food_repository.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodSearchController>(
      () => FoodSearchController(Get.find<FoodRepository>()),
    );
  }
}
