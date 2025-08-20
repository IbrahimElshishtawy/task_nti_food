import 'package:dio/dio.dart';
import 'package:food/data/api_model.dart';

class ApiClient {
  final String baseUrl = 'https://dummyjson.com';
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.options.validateStatus = (status) => status! < 500;
  }

  Future<List<ApiModel>> fetchRecipes() async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get('/recipes');
      final List recipesJson = response.data?['recipes'] ?? [];
      return recipesJson.map((json) => ApiModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception('Failed to load recipes: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<ApiModel>> fetchSuggestedRecipes() async {
    try {
      final allRecipes = await fetchRecipes();
      return allRecipes.take(5).toList();
    } catch (e) {
      throw Exception('Failed to load suggested recipes: $e');
    }
  }

  Future<List<ApiModel>> fetchRecipesWithNewInstance() async {
    try {
      final dioInstance = Dio();
      dioInstance.options.baseUrl = baseUrl;
      final Response<Map<String, dynamic>> response = await dioInstance.get(
        '/recipes',
      );
      if (response.statusCode == 200 && response.data != null) {
        final List recipesJson = response.data?['recipes'] ?? [];
        return recipesJson.map((json) => ApiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
