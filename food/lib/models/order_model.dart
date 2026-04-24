import 'cart_item_model.dart';

enum OrderStatus { pending, preparing, onTheWay, delivered, cancelled }

enum PaymentMethod { cashOnDelivery, creditCard, wallet }

extension OrderStatusX on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.onTheWay:
        return 'On the way';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get apiValue {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.preparing:
        return 'preparing';
      case OrderStatus.onTheWay:
        return 'on_the_way';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.cancelled:
        return 'cancelled';
    }
  }

  static OrderStatus fromApi(String value) {
    switch (value) {
      case 'preparing':
        return OrderStatus.preparing;
      case 'on_the_way':
      case 'onTheWay':
        return OrderStatus.onTheWay;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        return OrderStatus.pending;
    }
  }
}

extension PaymentMethodX on PaymentMethod {
  String get label {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'Cash on Delivery';
      case PaymentMethod.creditCard:
        return 'Credit Card';
      case PaymentMethod.wallet:
        return 'Wallet';
    }
  }

  String get apiValue {
    switch (this) {
      case PaymentMethod.cashOnDelivery:
        return 'cash_on_delivery';
      case PaymentMethod.creditCard:
        return 'credit_card';
      case PaymentMethod.wallet:
        return 'wallet';
    }
  }

  static PaymentMethod fromApi(String value) {
    switch (value) {
      case 'credit_card':
        return PaymentMethod.creditCard;
      case 'wallet':
        return PaymentMethod.wallet;
      default:
        return PaymentMethod.cashOnDelivery;
    }
  }
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.status,
    required this.address,
    required this.paymentMethod,
    required this.createdAt,
  });

  final String id;
  final List<CartItemModel> items;
  final double subtotal;
  final double deliveryFee;
  final double total;
  final OrderStatus status;
  final String address;
  final PaymentMethod paymentMethod;
  final DateTime createdAt;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: '${json['id'] ?? ''}',
      items: _cartItems(json['items']),
      subtotal: _toDouble(json['subtotal']),
      deliveryFee: _toDouble(json['deliveryFee'] ?? json['delivery_fee']),
      total: _toDouble(json['total']),
      status: OrderStatusX.fromApi('${json['status'] ?? ''}'),
      address: '${json['address'] ?? ''}',
      paymentMethod: PaymentMethodX.fromApi(
        '${json['paymentMethod'] ?? json['payment_method'] ?? ''}',
      ),
      createdAt: DateTime.tryParse('${json['createdAt'] ?? json['created_at'] ?? ''}') ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'items': items.map((item) => item.toJson()).toList(),
      'subtotal': subtotal,
      'deliveryFee': deliveryFee,
      'total': total,
      'status': status.apiValue,
      'address': address,
      'paymentMethod': paymentMethod.apiValue,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static List<CartItemModel> _cartItems(dynamic value) {
    if (value is! List) return const <CartItemModel>[];
    return value
        .whereType<Map>()
        .map((item) => CartItemModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  static double _toDouble(dynamic value, {double fallback = 0}) {
    if (value is num) return value.toDouble();
    return double.tryParse('$value') ?? fallback;
  }
}
