class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = 'https://api.example.com';
  static const String foods = '/foods';
  static const String categories = '/categories';
  static const String ads = '/ads';
  static const String search = '/search';
  static const String orders = '/orders';

  static String foodDetails(String id) => '/foods/$id';
}
