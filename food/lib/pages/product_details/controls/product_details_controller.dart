import 'package:flutter/foundation.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';

class ProductDetailsController extends ChangeNotifier {
  final ApiModel recipe;
  ProductDetailsController({required this.recipe}) {
    fetchSuggestedRecipes();
  }

  bool showDetails = false;
  List<ApiModel> suggestedRecipes = [];
  bool isLoading = true;
  String? error;

  final ApiClient _apiClient = ApiClient();

  void toggleDetails() {
    showDetails = !showDetails;
    notifyListeners();
  }

  Future<void> fetchSuggestedRecipes() async {
    isLoading = true;
    notifyListeners();

    try {
      final allRecipes = await _apiClient.fetchSuggestedRecipes();
      // ممكن تعمل فلتر عشان ماترجعش نفس الوصفة الحالية
      suggestedRecipes = allRecipes.where((r) => r.id != recipe.id).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }
}
