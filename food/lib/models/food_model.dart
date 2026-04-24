import 'review_model.dart';

class FoodModel {
  const FoodModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.prepTime,
    required this.categoryId,
    required this.ingredients,
    required this.calories,
    required this.reviews,
    this.isPopular = false,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final int reviewCount;
  final String prepTime;
  final String categoryId;
  final List<String> ingredients;
  final int calories;
  final List<ReviewModel> reviews;
  final bool isPopular;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      id: '${json['id'] ?? ''}',
      name: '${json['name'] ?? 'Untitled food'}',
      description: '${json['description'] ?? ''}',
      imageUrl: '${json['imageUrl'] ?? json['image_url'] ?? ''}',
      price: _toDouble(json['price']),
      rating: _toDouble(json['rating'], fallback: 4.5),
      reviewCount: _toInt(
        json['reviewCount'] ?? json['review_count'],
        fallback: 0,
      ),
      prepTime: '${json['prepTime'] ?? json['prep_time'] ?? '25 min'}',
      categoryId: '${json['categoryId'] ?? json['category_id'] ?? ''}',
      ingredients: _stringList(json['ingredients']),
      calories: _toInt(json['calories'], fallback: 0),
      reviews: _reviews(json['reviews']),
      isPopular: json['isPopular'] == true || json['is_popular'] == true,
    );
  }

  FoodModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? price,
    double? rating,
    int? reviewCount,
    String? prepTime,
    String? categoryId,
    List<String>? ingredients,
    int? calories,
    List<ReviewModel>? reviews,
    bool? isPopular,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      prepTime: prepTime ?? this.prepTime,
      categoryId: categoryId ?? this.categoryId,
      ingredients: ingredients ?? this.ingredients,
      calories: calories ?? this.calories,
      reviews: reviews ?? this.reviews,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'reviewCount': reviewCount,
      'prepTime': prepTime,
      'categoryId': categoryId,
      'ingredients': ingredients,
      'calories': calories,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'isPopular': isPopular,
    };
  }

  static double _toDouble(dynamic value, {double fallback = 0}) {
    if (value is num) return value.toDouble();
    return double.tryParse('$value') ?? fallback;
  }

  static int _toInt(dynamic value, {int fallback = 0}) {
    if (value is num) return value.toInt();
    return int.tryParse('$value') ?? fallback;
  }

  static List<String> _stringList(dynamic value) {
    if (value is! List) return const <String>[];
    return value.map((item) => '$item').toList();
  }

  static List<ReviewModel> _reviews(dynamic value) {
    if (value is! List) return const <ReviewModel>[];
    return value
        .whereType<Map>()
        .map((item) => ReviewModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }
}
