import 'package:dio/dio.dart';
import 'api_model.dart';

class ApiClient {
  final String baseUrl = 'https://dummyjson.com';
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    dio.options.validateStatus = (status) => status != null && status < 500;
  }

  Future<List<ApiModel>> fetchRecipes() async {
    try {
      final response = await dio.get('/recipes');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['recipes'] is List) {
          return (data['recipes'] as List)
              .map((item) => ApiModel.fromJson(Map<String, dynamic>.from(item)))
              .toList();
        } else {
          throw Exception('Unexpected response structure');
        }
      } else {
        throw Exception('Failed to fetch recipes: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<ApiModel>> fetchSuggestedRecipes({int take = 5}) async {
    final recipes = await fetchRecipes();
    return recipes.take(take).toList();
  }
}
