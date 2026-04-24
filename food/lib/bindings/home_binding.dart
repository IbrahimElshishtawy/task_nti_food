import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../data/repositories/food_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(
        () => HomeController(Get.find<FoodRepository>()),
        fenix: true,
      );
    }
  }
}
