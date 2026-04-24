import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import '../core/constants/storage_keys.dart';
import '../models/cart_item_model.dart';
import '../models/food_model.dart';
import '../services/storage_service.dart';
import '../utils/currency_formatter.dart';

class CartController extends GetxController {
  CartController(this._storageService);

  final StorageService _storageService;
  final RxList<CartItemModel> items = <CartItemModel>[].obs;

  double get subtotal {
    return items.fold<double>(0, (sum, item) => sum + item.lineTotal);
  }

  double get deliveryFee => items.isEmpty ? 0 : AppConstants.deliveryFee;

  double get total => subtotal + deliveryFee;

  int get totalItems {
    return items.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  String get totalLabel => CurrencyFormatter.format(total);

  @override
  void onInit() {
    super.onInit();
    _loadCart();
  }

  void addItem(FoodModel food, {int quantity = 1}) {
    final index = items.indexWhere((item) => item.food.id == food.id);
    if (index == -1) {
      items.add(CartItemModel(food: food, quantity: quantity));
    } else {
      final current = items[index];
      items[index] = current.copyWith(quantity: current.quantity + quantity);
    }
    _persistCart();
    Get.snackbar(
      'cart_added'.tr,
      'cart_added_message'.trParams(<String, String>{'food': food.name}),
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void increment(String foodId) {
    final index = items.indexWhere((item) => item.food.id == foodId);
    if (index == -1) return;
    final current = items[index];
    items[index] = current.copyWith(quantity: current.quantity + 1);
    _persistCart();
  }

  void decrement(String foodId) {
    final index = items.indexWhere((item) => item.food.id == foodId);
    if (index == -1) return;
    final current = items[index];
    if (current.quantity <= 1) {
      items.removeAt(index);
    } else {
      items[index] = current.copyWith(quantity: current.quantity - 1);
    }
    _persistCart();
  }

  void removeItem(String foodId) {
    items.removeWhere((item) => item.food.id == foodId);
    _persistCart();
  }

  void clearCart() {
    items.clear();
    _persistCart();
  }

  void _loadCart() {
    final stored = _storageService.readJsonList(StorageKeys.cartItems);
    items.assignAll(stored.map(CartItemModel.fromJson));
  }

  void _persistCart() {
    _storageService.writeJsonList(
      StorageKeys.cartItems,
      items.map((item) => item.toJson()).toList(),
    );
  }
}
