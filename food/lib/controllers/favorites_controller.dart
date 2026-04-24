import 'package:get/get.dart';

import '../core/constants/storage_keys.dart';
import '../models/food_model.dart';
import '../services/storage_service.dart';

class FavoritesController extends GetxController {
  FavoritesController(this._storageService);

  final StorageService _storageService;
  final RxList<FoodModel> favorites = <FoodModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadFavorites();
  }

  bool isFavorite(String foodId) {
    return favorites.any((food) => food.id == foodId);
  }

  void toggleFavorite(FoodModel food) {
    if (isFavorite(food.id)) {
      favorites.removeWhere((item) => item.id == food.id);
    } else {
      favorites.add(food);
    }
    _persistFavorites();
  }

  void removeFavorite(String foodId) {
    favorites.removeWhere((food) => food.id == foodId);
    _persistFavorites();
  }

  void _loadFavorites() {
    final stored = _storageService.readJsonList(StorageKeys.favorites);
    favorites.assignAll(stored.map(FoodModel.fromJson));
  }

  void _persistFavorites() {
    _storageService.writeJsonList(
      StorageKeys.favorites,
      favorites.map((food) => food.toJson()).toList(),
    );
  }
}
