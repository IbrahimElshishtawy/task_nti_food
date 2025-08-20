import 'package:dio/dio.dart';

class ApiClient {
  var baseUrl = 'https://dummyjson.com/recipes';
  var headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  final Dio dio = Dio();
  ApiClient() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = headers;
  }
  Future<List<dynamic>> fetchRecipes() async {
    try {
      final response = await dio.get('/all');
      if (response.statusCode == 200) {
        return response.data['recipes'];
      } else {
        throw Exception('Failed to load recipes');
      }
    } catch (e) {
      throw Exception('Failed to load recipes: $e');
    }
  }
}
