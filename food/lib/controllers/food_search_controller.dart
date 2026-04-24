import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/food_model.dart';

class FoodSearchController extends GetxController {
  FoodSearchController(this._repository);

  final FoodRepository _repository;
  final TextEditingController textController = TextEditingController();

  final RxString query = ''.obs;
  final Rx<ViewState> state = ViewState.idle.obs;
  final RxString errorMessage = ''.obs;
  final RxList<FoodModel> results = <FoodModel>[].obs;

  Worker? _worker;

  List<String> get suggestions {
    final text = query.value.toLowerCase();
    if (text.isEmpty) return AppConstants.searchChips;
    return AppConstants.searchChips
        .where((chip) => chip.toLowerCase().contains(text))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _worker = debounce<String>(
      query,
      _search,
      time: const Duration(milliseconds: 450),
    );
    final argument = Get.arguments;
    if (argument is String && argument.trim().isNotEmpty) {
      textController.text = argument;
      query.value = argument;
      _search(argument);
    }
  }

  void onQueryChanged(String value) {
    query.value = value.trim();
  }

  void useSuggestion(String value) {
    textController.text = value;
    query.value = value;
    _search(value);
  }

  Future<void> _search(String value) async {
    if (value.trim().isEmpty) {
      results.clear();
      state.value = ViewState.idle;
      return;
    }

    state.value = ViewState.loading;
    errorMessage.value = '';

    try {
      final foods = await _repository.searchFoods(value);
      results.assignAll(foods);
      state.value = foods.isEmpty ? ViewState.empty : ViewState.success;
    } catch (error) {
      errorMessage.value = '$error';
      state.value = ViewState.error;
    }
  }

  @override
  void onClose() {
    _worker?.dispose();
    textController.dispose();
    super.onClose();
  }
}
