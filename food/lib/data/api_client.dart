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

  // جلب كل الوصفات وتحويلها لـ List<ApiModel>
  Future<List<ApiModel>> fetchRecipes() async {
    try {
      final response = await dio.get('/recipes');

      if (response.statusCode == 200) {
        final List recipesJson = response.data['recipes'] ?? [];
        return recipesJson.map((json) => ApiModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load recipes: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  // جلب وصفة واحدة حسب ID
  Future<ApiModel> fetchRecipeById(int id) async {
    try {
      final response = await dio.get('/recipes/$id');

      if (response.statusCode == 200) {
        return ApiModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load recipe: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load recipe: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
