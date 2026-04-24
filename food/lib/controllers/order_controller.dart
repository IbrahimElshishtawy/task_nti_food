import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/order_model.dart';
import '../routes/app_routes.dart';
import 'cart_controller.dart';
import 'navigation_controller.dart';
import 'payment_controller.dart';

class OrderController extends GetxController {
  OrderController(this._repository);

  final FoodRepository _repository;
  final TextEditingController addressController = TextEditingController(
    text: AppConstants.defaultDeliveryLocation,
  );

  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final Rx<ViewState> historyState = ViewState.idle.obs;
  final Rx<ViewState> checkoutState = ViewState.idle.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedAddress = AppConstants.defaultDeliveryLocation.obs;

  final List<String> savedAddresses = const <String>[
    AppConstants.defaultDeliveryLocation,
    'New Cairo, Cairo',
    'Dokki, Giza',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    historyState.value = ViewState.loading;
    errorMessage.value = '';
    try {
      final result = await _repository.getOrders();
      orders.assignAll(result);
      historyState.value = result.isEmpty ? ViewState.empty : ViewState.success;
    } catch (error) {
      errorMessage.value = '$error';
      historyState.value = ViewState.error;
    }
  }

  void selectAddress(String address) {
    selectedAddress.value = address;
    addressController.text = address;
  }

  Future<void> submitOrder() async {
    final cartController = Get.find<CartController>();
    if (cartController.items.isEmpty) {
      Get.snackbar('cart_empty'.tr, 'cart_empty_message'.tr);
      return;
    }

    checkoutState.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final order = await _repository.submitOrder(
        items: cartController.items.toList(),
        address: addressController.text.trim().isEmpty
            ? selectedAddress.value
            : addressController.text.trim(),
        paymentMethod: Get.find<PaymentController>().selectedMethod.value,
      );
      orders.insert(0, order);
      cartController.clearCart();
      checkoutState.value = ViewState.success;
      if (Get.isRegistered<NavigationController>()) {
        Get.find<NavigationController>().changeTab(3);
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offNamed(AppRoutes.orders);
      }
      Get.snackbar('order_sent'.tr, 'order_sent_message'.tr);
    } catch (error) {
      errorMessage.value = '$error';
      checkoutState.value = ViewState.error;
    }
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}
