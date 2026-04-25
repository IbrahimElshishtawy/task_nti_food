import 'package:get/get.dart';

import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/food_model.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';
import 'favorites_controller.dart';
import 'navigation_controller.dart';

class FoodDetailsController extends GetxController {
  FoodDetailsController(this._repository);

  final FoodRepository _repository;
  final Rxn<FoodModel> food = Rxn<FoodModel>();
  final Rx<ViewState> state = ViewState.loading.obs;
  final RxString errorMessage = ''.obs;
  final RxInt quantity = 1.obs;
  final RxDouble userRating = 0.0.obs;
  final RxString selectedSize = ''.obs;
  final RxList<String> selectedExtras = <String>[].obs;
  final RxList<FoodModel> recommendations = <FoodModel>[].obs;

  double get totalPrice {
    final currentFood = food.value;
    if (currentFood == null) return 0;
    final extrasPrice = selectedExtras.length * 0.75;
    return (currentFood.price + extrasPrice) * quantity.value;
  }

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
      _syncSelections(argument);
      state.value = ViewState.success;
      await _loadRecommendations(argument);
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
      _syncSelections(result);
      state.value = ViewState.success;
      await _loadRecommendations(result);
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
    if (Get.isRegistered<NavigationController>()) {
      Get.find<NavigationController>().changeTab(3);
    }
    Get.toNamed(AppRoutes.checkout);
  }

  void setRating(double value) {
    userRating.value = value;
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void toggleExtra(String extra) {
    if (selectedExtras.contains(extra)) {
      selectedExtras.remove(extra);
    } else {
      selectedExtras.add(extra);
    }
  }

  void _syncSelections(FoodModel value) {
    selectedSize.value = value.sizes.isEmpty ? '' : value.sizes.first;
    selectedExtras.clear();
    quantity.value = 1;
  }

  Future<void> _loadRecommendations(FoodModel currentFood) async {
    try {
      final foods = await _repository.getFoods();
      final drinkCategories = <String>{
        'cold_drinks',
        'hot_drinks',
        'juices',
        'coffee',
        'tea',
      };

      final candidates =
          foods
              .where((food) => food.id != currentFood.id && food.isAvailable)
              .toList()
            ..sort((a, b) {
              final aScore = _recommendationScore(
                a,
                currentFood,
                drinkCategories,
              );
              final bScore = _recommendationScore(
                b,
                currentFood,
                drinkCategories,
              );
              return bScore.compareTo(aScore);
            });

      recommendations.assignAll(candidates.take(8));
    } catch (_) {
      recommendations.clear();
    }
  }

  int _recommendationScore(
    FoodModel food,
    FoodModel currentFood,
    Set<String> drinkCategories,
  ) {
    var score = 0;
    if (food.categoryId == currentFood.categoryId) score += 6;
    if (drinkCategories.contains(food.categoryId)) score += 5;
    if (food.isRecommended) score += 4;
    if (food.isPopular) score += 2;
    score += food.rating.round();
    return score;
  }
}
