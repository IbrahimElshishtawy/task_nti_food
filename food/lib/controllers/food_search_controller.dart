import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constants/app_constants.dart';
import '../core/constants/storage_keys.dart';
import '../core/state/view_state.dart';
import '../data/repositories/food_repository.dart';
import '../models/food_model.dart';
import '../services/storage_service.dart';

class FoodSearchController extends GetxController {
  FoodSearchController(this._repository, this._storageService);

  final FoodRepository _repository;
  final StorageService _storageService;
  final TextEditingController textController = TextEditingController();

  final RxString query = ''.obs;
  final Rx<ViewState> state = ViewState.idle.obs;
  final RxString errorMessage = ''.obs;
  final RxList<FoodModel> results = <FoodModel>[].obs;
  final RxList<FoodModel> allFoods = <FoodModel>[].obs;
  final RxList<String> recentSearches = <String>[].obs;

  Worker? _worker;

  List<String> get suggestions {
    final text = query.value.toLowerCase();
    final source = <String>{
      ...recentSearches,
      ...AppConstants.searchChips,
      ...allFoods.map((food) => food.name),
    }.toList();
    if (text.isEmpty) return source.take(10).toList();
    return source
        .where((chip) => chip.toLowerCase().contains(text))
        .take(12)
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
    _loadSuggestionFoods();
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
      if (foods.isNotEmpty) _saveRecent(value);
    } catch (error) {
      errorMessage.value = '$error';
      state.value = ViewState.error;
    }
  }

  Future<void> _loadSuggestionFoods() async {
    try {
      allFoods.assignAll(await _repository.getFoods());
    } catch (_) {
      allFoods.clear();
    }
  }

  void _loadRecentSearches() {
    final stored = _storageService.read<List<dynamic>>(
      StorageKeys.recentSearches,
    );
    recentSearches.assignAll(
      (stored ?? const <dynamic>[]).map((item) => '$item'),
    );
  }

  void _saveRecent(String value) {
    final normalized = value.trim();
    if (normalized.isEmpty) return;

    recentSearches.removeWhere(
      (item) => item.toLowerCase() == normalized.toLowerCase(),
    );
    recentSearches.insert(0, normalized);
    if (recentSearches.length > 8) {
      recentSearches.removeRange(8, recentSearches.length);
    }
    _storageService.write(StorageKeys.recentSearches, recentSearches.toList());
  }

  @override
  void onClose() {
    _worker?.dispose();
    textController.dispose();
    super.onClose();
  }
}
