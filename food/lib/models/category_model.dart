import 'package:get/get.dart';

class CategoryModel {
  const CategoryModel({
    required this.id,
    String? name,
    String? nameAr,
    String? nameEn,
    required this.imageUrl,
    required this.colorHex,
  }) : nameAr = nameAr ?? name ?? '',
       nameEn = nameEn ?? name ?? '';

  final String id;
  final String nameAr;
  final String nameEn;
  final String imageUrl;
  final String colorHex;

  String get name => Get.locale?.languageCode == 'ar' ? nameAr : nameEn;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final fallbackName = '${json['name'] ?? ''}';
    return CategoryModel(
      id: '${json['id'] ?? ''}',
      nameAr: '${json['nameAr'] ?? json['name_ar'] ?? fallbackName}',
      nameEn: '${json['nameEn'] ?? json['name_en'] ?? fallbackName}',
      imageUrl: '${json['imageUrl'] ?? json['image_url'] ?? ''}',
      colorHex: '${json['colorHex'] ?? json['color_hex'] ?? 'FFF6EA'}',
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'nameAr': nameAr,
      'nameEn': nameEn,
      'name': nameEn,
      'imageUrl': imageUrl,
      'colorHex': colorHex,
    };
  }
}
