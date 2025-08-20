import 'package:flutter/material.dart';
import 'package:food/data/api_client.dart';
import 'package:food/data/api_model.dart';

class ProductDetailsController extends ChangeNotifier {
  final ApiModel recipe;
  final ApiClient apiClient = ApiClient();

  bool isLoading = false;
  String? error;
  List<ApiModel> suggestedRecipes = [];
  bool showDetails = false;

  ProductDetailsController({required this.recipe}) {
    fetchSuggested();
  }

  void toggleDetails() {
    showDetails = !showDetails;
    notifyListeners();
  }

  Future<void> fetchSuggested() async {
    isLoading = true;
    notifyListeners();
    try {
      suggestedRecipes = await apiClient.fetchSuggestedRecipes();
      error = null;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
