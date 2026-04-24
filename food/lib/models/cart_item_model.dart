import 'food_model.dart';

class CartItemModel {
  const CartItemModel({required this.food, required this.quantity});

  final FoodModel food;
  final int quantity;

  double get lineTotal => food.price * quantity;

  CartItemModel copyWith({FoodModel? food, int? quantity}) {
    return CartItemModel(
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final foodJson = json['food'];
    return CartItemModel(
      food: FoodModel.fromJson(
        foodJson is Map
            ? Map<String, dynamic>.from(foodJson)
            : <String, dynamic>{},
      ),
      quantity: _toInt(json['quantity'], fallback: 1),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'food': food.toJson(), 'quantity': quantity};
  }

  Map<String, dynamic> toOrderJson() {
    return <String, dynamic>{
      'food_id': food.id,
      'quantity': quantity,
      'price': food.price,
    };
  }

  static int _toInt(dynamic value, {int fallback = 1}) {
    if (value is num) return value.toInt();
    return int.tryParse('$value') ?? fallback;
  }
}
