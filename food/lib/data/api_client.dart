import 'package:dio/dio.dart';

class ApiClient {
  final String baseUrl = 'https://dummyjson.com';
  final Dio dio = Dio();

  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    // السماح بكل الاستجابات أقل من 500
    dio.options.validateStatus = (status) => status! < 500;
  }

  Future<List<dynamic>> fetchRecipes() async {
    try {
      final response = await dio.get('/recipes');

      if (response.statusCode == 200) {
        return response.data['recipes'] ?? [];
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load recipes: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
