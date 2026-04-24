import 'package:get/get.dart';

import 'review_model.dart';

class FoodModel {
  const FoodModel({
    required this.id,
    String? name,
    String? description,
    String? nameAr,
    String? nameEn,
    String? descriptionAr,
    String? descriptionEn,
    required this.imageUrl,
    required this.price,
    this.oldPrice = 0,
    required this.rating,
    int? reviewCount,
    int? reviewsCount,
    String? prepTime,
    String? preparationTime,
    required this.categoryId,
    required this.ingredients,
    required this.calories,
    required this.reviews,
    this.isPopular = false,
    this.isRecommended = false,
    this.isAvailable = true,
    this.sizes = const <String>[],
    this.extras = const <String>[],
  }) : nameAr = nameAr ?? name ?? '',
       nameEn = nameEn ?? name ?? '',
       descriptionAr = descriptionAr ?? description ?? '',
       descriptionEn = descriptionEn ?? description ?? '',
       reviewsCount = reviewsCount ?? reviewCount ?? 0,
       preparationTime = preparationTime ?? prepTime ?? '25 min';

  final String id;
  final String nameAr;
  final String nameEn;
  final String descriptionAr;
  final String descriptionEn;
  final String imageUrl;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviewsCount;
  final String preparationTime;
  final String categoryId;
  final List<String> ingredients;
  final int calories;
  final List<ReviewModel> reviews;
  final bool isPopular;
  final bool isRecommended;
  final bool isAvailable;
  final List<String> sizes;
  final List<String> extras;

  String get name => Get.locale?.languageCode == 'ar' ? nameAr : nameEn;

  String get description =>
      Get.locale?.languageCode == 'ar' ? descriptionAr : descriptionEn;

  int get reviewCount => reviewsCount;

  String get prepTime => preparationTime;

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    final fallbackName = '${json['name'] ?? json['title'] ?? 'Untitled food'}';
    final fallbackDescription = '${json['description'] ?? ''}';
    return FoodModel(
      id: '${json['id'] ?? ''}',
      nameAr: '${json['nameAr'] ?? json['name_ar'] ?? fallbackName}',
      nameEn: '${json['nameEn'] ?? json['name_en'] ?? fallbackName}',
      descriptionAr:
          '${json['descriptionAr'] ?? json['description_ar'] ?? fallbackDescription}',
      descriptionEn:
          '${json['descriptionEn'] ?? json['description_en'] ?? fallbackDescription}',
      imageUrl: '${json['imageUrl'] ?? json['image_url'] ?? ''}',
      price: _toDouble(json['price']),
      oldPrice: _toDouble(json['oldPrice'] ?? json['old_price']),
      rating: _toDouble(json['rating'], fallback: 4.5),
      reviewsCount: _toInt(
        json['reviewsCount'] ??
            json['reviews_count'] ??
            json['reviewCount'] ??
            json['review_count'],
        fallback: 0,
      ),
      preparationTime:
          '${json['preparationTime'] ?? json['preparation_time'] ?? json['prepTime'] ?? json['prep_time'] ?? '25 min'}',
      categoryId: '${json['categoryId'] ?? json['category_id'] ?? ''}',
      ingredients: _stringList(json['ingredients']),
      calories: _toInt(json['calories'], fallback: 0),
      reviews: _reviews(json['reviews']),
      isPopular: json['isPopular'] == true || json['is_popular'] == true,
      isRecommended:
          json['isRecommended'] == true || json['is_recommended'] == true,
      isAvailable:
          json['isAvailable'] != false && json['is_available'] != false,
      sizes: _stringList(json['sizes']),
      extras: _stringList(json['extras']),
    );
  }

  FoodModel copyWith({
    String? id,
    String? nameAr,
    String? nameEn,
    String? descriptionAr,
    String? descriptionEn,
    String? imageUrl,
    double? price,
    double? oldPrice,
    double? rating,
    int? reviewsCount,
    String? preparationTime,
    String? categoryId,
    List<String>? ingredients,
    int? calories,
    List<ReviewModel>? reviews,
    bool? isPopular,
    bool? isRecommended,
    bool? isAvailable,
    List<String>? sizes,
    List<String>? extras,
  }) {
    return FoodModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      descriptionEn: descriptionEn ?? this.descriptionEn,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      oldPrice: oldPrice ?? this.oldPrice,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      preparationTime: preparationTime ?? this.preparationTime,
      categoryId: categoryId ?? this.categoryId,
      ingredients: ingredients ?? this.ingredients,
      calories: calories ?? this.calories,
      reviews: reviews ?? this.reviews,
      isPopular: isPopular ?? this.isPopular,
      isRecommended: isRecommended ?? this.isRecommended,
      isAvailable: isAvailable ?? this.isAvailable,
      sizes: sizes ?? this.sizes,
      extras: extras ?? this.extras,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'descriptionAr': descriptionAr,
      'descriptionEn': descriptionEn,
      'name': nameEn,
      'description': descriptionEn,
      'imageUrl': imageUrl,
      'price': price,
      'oldPrice': oldPrice,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'reviewCount': reviewsCount,
      'preparationTime': preparationTime,
      'prepTime': preparationTime,
      'categoryId': categoryId,
      'ingredients': ingredients,
      'calories': calories,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'isPopular': isPopular,
      'isRecommended': isRecommended,
      'isAvailable': isAvailable,
      'sizes': sizes,
      'extras': extras,
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
