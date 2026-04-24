import 'package:get/get.dart';

import '../controllers/order_controller.dart';
import '../data/repositories/food_repository.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<OrderController>()) {
      Get.lazyPut<OrderController>(
        () => OrderController(Get.find<FoodRepository>()),
        fenix: true,
      );
    }
  }
}
