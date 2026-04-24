import '../models/ad_model.dart';
import '../models/cart_item_model.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import '../models/order_model.dart';
import '../models/review_model.dart';
import 'mock_food_data.dart';

class MockData {
  const MockData._();

  static List<CategoryModel> get categories => MockFoodData.categories;
  static List<AdModel> get ads => MockFoodData.ads;
  static List<ReviewModel> get reviews => MockFoodData.reviews;
  static List<FoodModel> get foods => MockFoodData.foods;

  static List<OrderModel> orders() {
    return <OrderModel>[
      OrderModel(
        id: 'ORD-1028',
        items: <CartItemModel>[
          CartItemModel(food: foods[3], quantity: 1),
          CartItemModel(food: foods[23], quantity: 2),
        ],
        subtotal: foods[3].price + (foods[23].price * 2),
        deliveryFee: 4.99,
        total: foods[3].price + (foods[23].price * 2) + 4.99,
        status: OrderStatus.delivered,
        address: 'Nasr City, Cairo',
        paymentMethod: PaymentMethod.cashOnDelivery,
        createdAt: DateTime(2026, 4, 20, 19, 35),
      ),
      OrderModel(
        id: 'ORD-1037',
        items: <CartItemModel>[CartItemModel(food: foods[0], quantity: 2)],
        subtotal: foods[0].price * 2,
        deliveryFee: 4.99,
        total: (foods[0].price * 2) + 4.99,
        status: OrderStatus.onTheWay,
        address: 'Nasr City, Cairo',
        paymentMethod: PaymentMethod.wallet,
        createdAt: DateTime(2026, 4, 24, 21, 10),
      ),
    ];
  }
}
