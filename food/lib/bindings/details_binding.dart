import 'package:get/get.dart';

import '../controllers/food_details_controller.dart';
import '../data/repositories/food_repository.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodDetailsController>(
      () => FoodDetailsController(Get.find<FoodRepository>()),
    );
  }
}
