import 'package:get/get.dart';

import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/food_model.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';
import 'favorites_controller.dart';

class FoodDetailsController extends GetxController {
  FoodDetailsController(this._repository);

  final FoodRepository _repository;
  final Rxn<FoodModel> food = Rxn<FoodModel>();
  final Rx<ViewState> state = ViewState.loading.obs;
  final RxString errorMessage = ''.obs;
  final RxInt quantity = 1.obs;
  final RxDouble userRating = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialFood();
  }

  bool get isFavorite {
    final currentFood = food.value;
    if (currentFood == null) return false;
    return Get.find<FavoritesController>().isFavorite(currentFood.id);
  }

  Future<void> _loadInitialFood() async {
    final argument = Get.arguments;
    if (argument is FoodModel) {
      food.value = argument;
      state.value = ViewState.success;
      return;
    }

    final id = '${Get.parameters['id'] ?? argument ?? ''}';
    if (id.isEmpty) {
      state.value = ViewState.error;
      errorMessage.value = 'Food item was not found.';
      return;
    }

    await loadFood(id);
  }

  Future<void> loadFood(String id) async {
    state.value = ViewState.loading;
    errorMessage.value = '';
    try {
      final result = await _repository.getFoodDetails(id);
      food.value = result;
      state.value = ViewState.success;
    } catch (error) {
      errorMessage.value = '$error';
      state.value = ViewState.error;
    }
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) quantity.value--;
  }

  void toggleFavorite() {
    final currentFood = food.value;
    if (currentFood == null) return;
    Get.find<FavoritesController>().toggleFavorite(currentFood);
  }

  void addToCart() {
    final currentFood = food.value;
    if (currentFood == null) return;
    Get.find<CartController>().addItem(currentFood, quantity: quantity.value);
  }

  void orderNow() {
    addToCart();
    Get.toNamed(AppRoutes.checkout);
  }

  void setRating(double value) {
    userRating.value = value;
  }
}
