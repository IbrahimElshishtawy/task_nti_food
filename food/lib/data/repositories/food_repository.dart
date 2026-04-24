import '../../core/constants/api_endpoints.dart';
import '../../core/constants/app_constants.dart';
import '../../models/ad_model.dart';
import '../../models/cart_item_model.dart';
import '../../models/category_model.dart';
import '../../models/food_model.dart';
import '../../models/order_model.dart';
import '../../services/api_service.dart';
import '../mock_data.dart';

class FoodRepository {
  const FoodRepository(this._apiService);

  final ApiService _apiService;

  Future<List<FoodModel>> getFoods() async {
    if (_usesMockApi) {
      await _shortDelay();
      return MockData.foods;
    }

    try {
      final response = await _apiService.get(ApiEndpoints.foods);
      return _decodeList(response.data, FoodModel.fromJson);
    } catch (_) {
      await _shortDelay();
      return MockData.foods;
    }
  }

  Future<FoodModel> getFoodDetails(String id) async {
    if (_usesMockApi) {
      await _shortDelay();
      return MockData.foods.firstWhere(
        (food) => food.id == id,
        orElse: () => MockData.foods.first,
      );
    }

    try {
      final response = await _apiService.get(ApiEndpoints.foodDetails(id));
      return FoodModel.fromJson(_decodeMap(response.data));
    } catch (_) {
      await _shortDelay();
      return MockData.foods.firstWhere(
        (food) => food.id == id,
        orElse: () => MockData.foods.first,
      );
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    if (_usesMockApi) {
      await _shortDelay();
      return MockData.categories;
    }

    try {
      final response = await _apiService.get(ApiEndpoints.categories);
      return _decodeList(response.data, CategoryModel.fromJson);
    } catch (_) {
      await _shortDelay();
      return MockData.categories;
    }
  }

  Future<List<AdModel>> getAds() async {
    if (_usesMockApi) {
      await _shortDelay();
      return MockData.ads;
    }

    try {
      final response = await _apiService.get(ApiEndpoints.ads);
      return _decodeList(response.data, AdModel.fromJson);
    } catch (_) {
      await _shortDelay();
      return MockData.ads;
    }
  }

  Future<List<FoodModel>> searchFoods(String query) async {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return const <FoodModel>[];

    if (_usesMockApi) {
      await _shortDelay();
      return _filterMockFoods(normalizedQuery);
    }

    try {
      final response = await _apiService.get(
        ApiEndpoints.search,
        queryParameters: <String, dynamic>{'query': query},
      );
      return _decodeList(response.data, FoodModel.fromJson);
    } catch (_) {
      await _shortDelay();
      return _filterMockFoods(normalizedQuery);
    }
  }

  Future<OrderModel> submitOrder({
    required List<CartItemModel> items,
    required String address,
    required PaymentMethod paymentMethod,
  }) async {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.lineTotal);
    final deliveryFee = items.isEmpty ? 0.0 : AppConstants.deliveryFee;
    final payload = <String, dynamic>{
      'items': items.map((item) => item.toOrderJson()).toList(),
      'address': address,
      'payment_method': paymentMethod.apiValue,
      'subtotal': subtotal,
      'delivery_fee': deliveryFee,
      'total': subtotal + deliveryFee,
    };

    if (_usesMockApi) {
      await _shortDelay();
      return _mockOrder(
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        address: address,
        paymentMethod: paymentMethod,
      );
    }

    try {
      final response = await _apiService.post(
        ApiEndpoints.orders,
        data: payload,
      );
      return OrderModel.fromJson(_decodeMap(response.data));
    } catch (_) {
      await _shortDelay();
      return _mockOrder(
        items: items,
        subtotal: subtotal,
        deliveryFee: deliveryFee,
        address: address,
        paymentMethod: paymentMethod,
      );
    }
  }

  Future<List<OrderModel>> getOrders() async {
    if (_usesMockApi) {
      await _shortDelay();
      return MockData.orders();
    }

    try {
      final response = await _apiService.get(ApiEndpoints.orders);
      return _decodeList(response.data, OrderModel.fromJson);
    } catch (_) {
      await _shortDelay();
      return MockData.orders();
    }
  }

  Map<String, dynamic> _decodeMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      final nested = data['data'];
      if (nested is Map<String, dynamic>) return nested;
      return data;
    }
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }

  List<T> _decodeList<T>(
    dynamic data,
    T Function(Map<String, dynamic> json) mapper,
  ) {
    dynamic source = data;
    if (source is Map) {
      source = source['data'] ?? source['items'] ?? source['results'];
    }
    if (source is! List) return <T>[];
    return source
        .whereType<Map>()
        .map((item) => mapper(Map<String, dynamic>.from(item)))
        .toList();
  }

  bool get _usesMockApi => ApiEndpoints.baseUrl.contains('api.example.com');

  List<FoodModel> _filterMockFoods(String normalizedQuery) {
    return MockData.foods.where((food) {
      return food.name.toLowerCase().contains(normalizedQuery) ||
          food.description.toLowerCase().contains(normalizedQuery) ||
          food.categoryId.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  OrderModel _mockOrder({
    required List<CartItemModel> items,
    required double subtotal,
    required double deliveryFee,
    required String address,
    required PaymentMethod paymentMethod,
  }) {
    return OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      items: List<CartItemModel>.from(items),
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: subtotal + deliveryFee,
      status: OrderStatus.pending,
      address: address,
      paymentMethod: paymentMethod,
      createdAt: DateTime.now(),
    );
  }

  Future<void> _shortDelay() {
    return Future<void>.delayed(const Duration(milliseconds: 450));
  }
}
