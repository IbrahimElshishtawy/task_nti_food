import 'package:get/get.dart';

import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/ad_model.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import 'cart_controller.dart';
import 'favorites_controller.dart';

class HomeController extends GetxController {
  HomeController(this._repository);

  final FoodRepository _repository;

  final Rx<ViewState> state = ViewState.idle.obs;
  final RxString errorMessage = ''.obs;
  final RxList<FoodModel> foods = <FoodModel>[].obs;
  final RxList<CategoryModel> categories = <CategoryModel>[].obs;
  final RxList<AdModel> ads = <AdModel>[].obs;
  final RxString selectedCategoryId = 'all'.obs;
  final RxInt currentAdIndex = 0.obs;

  List<FoodModel> get filteredFoods {
    if (selectedCategoryId.value == 'all') return foods;
    return foods
        .where((food) => food.categoryId == selectedCategoryId.value)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    state.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final results = await Future.wait<dynamic>(<Future<dynamic>>[
        _repository.getFoods(),
        _repository.getCategories(),
        _repository.getAds(),
      ]);
      foods.assignAll(results[0] as List<FoodModel>);
      categories.assignAll(results[1] as List<CategoryModel>);
      ads.assignAll(results[2] as List<AdModel>);
      state.value = foods.isEmpty ? ViewState.empty : ViewState.success;
    } catch (error) {
      errorMessage.value = '$error';
      state.value = ViewState.error;
    }
  }

  void selectCategory(String categoryId) {
    selectedCategoryId.value = categoryId;
  }

  void changeAd(int index) {
    currentAdIndex.value = index;
  }

  void toggleFavorite(FoodModel food) {
    Get.find<FavoritesController>().toggleFavorite(food);
  }

  void addToCart(FoodModel food) {
    Get.find<CartController>().addItem(food);
  }
}
